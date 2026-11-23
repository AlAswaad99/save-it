import { createClient } from "npm:@supabase/supabase-js@2";
import { Webhook } from "npm:standardwebhooks@1.0.0";
import { loginCodeEmail } from "../_shared/emails/login_code.ts";

const hookSecret = (Deno.env.get("SEND_EMAIL_HOOK_SECRET") ?? "").replace(
  "v1,whsec_",
  "",
);
const resendKey = Deno.env.get("RESEND_API_KEY") ?? "";
const fromAddress = Deno.env.get("RESEND_FROM") ??
  "Save It <onboarding@resend.dev>";

type HookPayload = {
  user: { email?: string };
  email_data: { token?: string };
};

Deno.serve(async (request) => {
  if (request.method !== "POST") {
    return hookError(405, "SI001");
  }

  const body = await request.text();
  let payload: HookPayload;
  try {
    const headers = Object.fromEntries(request.headers);
    payload = new Webhook(hookSecret).verify(body, headers) as HookPayload;
  } catch {
    return hookError(401, "SI001");
  }

  const email = payload.user.email?.trim() ?? "";
  const code = payload.email_data.token ?? "";
  if (email === "" || code === "") {
    return hookError(400, "SI001");
  }

  const supabase = createClient(
    Deno.env.get("SUPABASE_URL") ?? "",
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "",
  );

  const reserved = await supabase.rpc("reserve_login_code", { p_email: email });
  if (reserved.error) {
    return hookError(500, "SI001");
  }

  const decision = reserved.data as { ok?: boolean; code?: string } | null;
  if (decision?.ok === false) {
    return hookError(429, decision.code ?? "SI050");
  }

  const message = loginCodeEmail(code);
  const sent = await fetch("https://api.resend.com/emails", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${resendKey}`,
      "Content-Type": "application/json",
      "Idempotency-Key": `login-code:${email}:${code}`,
    },
    body: JSON.stringify({
      from: fromAddress,
      to: [email],
      subject: message.subject,
      html: message.html,
      text: message.text,
    }),
  });

  if (!sent.ok) {
    await supabase.rpc("release_login_code", { p_email: email });
    return hookError(500, "SI001");
  }

  return json({}, 200);
});

// Auth forwards a hook error only when the HTTP status is 200 or 202.
// A 429 is reported to the app as "Service currently unavailable due to hook".
function hookError(httpCode: number, message: string): Response {
  return json({ error: { http_code: httpCode, message } }, 200);
}

function json(body: unknown, status: number): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "Content-Type": "application/json" },
  });
}
