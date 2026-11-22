const supportEmail = "contact@arisehub.org";

export function loginCodeEmail(code: string): { subject: string; text: string; html: string } {
  const subject = "Your Save It code";
  const text = [
    `Your Save It code is ${code}.`,
    "It expires in 10 minutes.",
    "If you did not request this email, you can ignore it.",
    "",
    `Support: ${supportEmail}`,
  ].join("\n");

  const html = `<!DOCTYPE html>
<html lang="en">
  <body style="margin:0;background:#F7F3EC;color:#1C1B19;font-family:Arial,sans-serif;">
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#F7F3EC;padding:32px 16px;">
      <tr>
        <td align="center">
          <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:480px;background:#FFFFFF;border-radius:12px;padding:32px;">
            <tr>
              <td style="font-size:22px;font-weight:700;color:#5B7B3A;">Save It</td>
            </tr>
            <tr>
              <td style="padding-top:24px;font-size:16px;line-height:1.5;">Your code is</td>
            </tr>
            <tr>
              <td style="padding-top:8px;font-size:32px;letter-spacing:6px;font-weight:700;">${escapeHtml(code)}</td>
            </tr>
            <tr>
              <td style="padding-top:16px;font-size:16px;line-height:1.5;">It expires in 10 minutes.</td>
            </tr>
            <tr>
              <td style="padding-top:16px;font-size:16px;line-height:1.5;">If you did not request this email, you can ignore it.</td>
            </tr>
            <tr>
              <td style="padding-top:32px;font-size:14px;color:#6B635C;">Support: ${supportEmail}</td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>`;

  return { subject, text, html };
}

function escapeHtml(value: string): string {
  return value
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;");
}
