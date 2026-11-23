const walkthrough =
  "Join many others in reducing food waste as food venues around Abu Dhabi share their surplus food every evening at a discounted rate! Why let good food go to waste?";

export function welcomeEmail(input: {
  name: string;
  supportEmail: string;
}): { subject: string; text: string; html: string } {
  const subject = "You're in! Welcome to Save It";
  const greeting =
    `Hi ${input.name}, Marhaba! Welcome to Save It! You are now with many others who have joined this good sustainability act of helping to reduce food waste in the UAE whilst saving money too - it's a win win!`;
  const text = [greeting, "", walkthrough, "", `Support: ${input.supportEmail}`].join(
    "\n",
  );
  const html = `<!DOCTYPE html>
<html lang="en">
  <body style="margin:0;background:#F7F3EC;color:#1C1B19;font-family:Arial,sans-serif;">
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#F7F3EC;padding:32px 16px;">
      <tr>
        <td align="center">
          <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:480px;background:#FFFFFF;border-radius:12px;padding:32px;">
            <tr><td style="font-size:22px;font-weight:700;color:#5B7B3A;">Save It</td></tr>
            <tr><td style="padding-top:24px;font-size:16px;line-height:1.5;">${escapeHtml(greeting)}</td></tr>
            <tr><td style="padding-top:16px;font-size:16px;line-height:1.5;">${escapeHtml(walkthrough)}</td></tr>
            <tr><td style="padding-top:32px;font-size:14px;color:#6B635C;">Support: ${escapeHtml(input.supportEmail)}</td></tr>
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
