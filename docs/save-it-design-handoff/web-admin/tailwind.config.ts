import type { Config } from "tailwindcss";

// Save It admin dashboard. Load Titillium Web (400/600/700), e.g. with next/font/google.
const config: Config = {
  content: ["./app/**/*.{ts,tsx}", "./components/**/*.{ts,tsx}", "./src/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        "si-primary": "#5B7B3A",
        "si-primary-text": "#587738",
        "si-primary-container": "#E9EFE1",
        "si-on-primary-container": "#4F6B32",
        "si-accent": "#B5543A",
        "si-accent-text": "#B15239",
        "si-background": "#F7F3EC",
        "si-surface": "#FFFFFF",
        "si-surface-muted": "#EFEAE1",
        "si-table-header": "#FBF9F5",
        "si-outline": "#E2DBD0",
        "si-outline-strong": "#8C847B",
        "si-text-primary": "#1C1B19",
        "si-text-secondary": "#6B635C",
        "si-success-tint": "#E4F0E2",
        "si-success": "#2E6B3A",
        "si-warning-tint": "#FCEFD2",
        "si-warning": "#7A5200",
        "si-error-tint": "#FBE7EA",
        "si-error": "#B4233C",
        "si-neutral-tint": "#ECE9E4",
        "si-neutral": "#55504A",
        "si-dark": "#2B2926",
        "si-business-badge": "#C6DDA8",
      },
      borderRadius: {
        thumb: "8px",
        control: "12px",
        card: "20px",
        sheet: "28px",
      },
      boxShadow: {
        e1: "0 1px 2px rgba(28,27,25,.06), 0 4px 12px rgba(28,27,25,.06)",
        e2: "0 -4px 16px rgba(28,27,25,.08)",
        e3: "0 12px 32px rgba(28,27,25,.18)",
      },
      fontFamily: {
        sans: ["var(--font-titillium)", "Titillium Web", "system-ui", "sans-serif"],
      },
      fontSize: {
        "si-display": ["34px", { lineHeight: "40px", fontWeight: "700" }],
        "si-screen-title": ["28px", { lineHeight: "34px", fontWeight: "700" }],
        "si-title": ["26px", { lineHeight: "32px", fontWeight: "700" }],
        "si-sheet-title": ["22px", { lineHeight: "28px", fontWeight: "700" }],
        "si-headline": ["20px", { lineHeight: "26px", fontWeight: "600" }],
        "si-app-bar": ["18px", { lineHeight: "24px", fontWeight: "600" }],
        "si-body": ["16px", { lineHeight: "24px", fontWeight: "400" }],
        "si-body-small": ["14px", { lineHeight: "20px", fontWeight: "400" }],
        "si-label": ["16px", { lineHeight: "20px", fontWeight: "600" }],
        "si-label-small": ["14px", { lineHeight: "20px", fontWeight: "600" }],
        "si-caption": ["12px", { lineHeight: "16px", fontWeight: "400" }],
        "si-badge": ["12px", { lineHeight: "16px", fontWeight: "700", letterSpacing: "0.06em" }],
        "si-code": ["32px", { lineHeight: "40px", fontWeight: "700", letterSpacing: "0.18em" }],
        "si-pass-code": ["40px", { lineHeight: "48px", fontWeight: "700", letterSpacing: "0.18em" }],
      },
      height: { control: "40px" },
      width: { sidebar: "248px" },
    },
  },
  plugins: [],
};

export default config;
