# Open Security Assessment Report (OSAR) Toolkit to create a Security Impact Report (SIR) — ChatGPT Edition

An open-source, organization-agnostic toolkit for producing decision-grade **security and impact reports** on technology assets — applications, vendor SaaS, infrastructure changes, source-code releases — deployed as an **OpenAI ChatGPT Custom GPT** suitable for consumer Plus, Team, and Enterprise tiers.

This is the ChatGPT-tailored fork of the model-agnostic SIR toolkit. The architecture is the same hub-and-spoke prompt system: a Main Instructions file orchestrates the report and seven specialized analysis modules cover cost, infrastructure impact, NIST 800-53 control inheritance, plan-of-action-and-milestones (POA&M), source-code analysis, vendor compliance, and WCAG accessibility. The output is a defensible, decision-grade report suitable for security review boards, change-advisory boards, and risk committees.

## What's different in the ChatGPT Edition

- **Custom GPT–native deployment.** Distilled instructions sized to fit the 8,000-character Custom GPT Instructions field, with the spec and modules uploaded as knowledge files.
- **In-chat configurator.** On first run, the GPT walks the user through a four-group questionnaire (Identity, Vendor Stack, Jurisdiction, Brand) and emits a reusable Session Config block.
- **Code Interpreter and Web Browsing affordances** built into the analysis tasks: gzip and file-size measurement against uploaded source, regex-based sensitive-data sweeps, vendor FedRAMP / SOC 2 verification, NIST revision currency checks, contrast-ratio checks for WCAG, and POA&M XLSX export.
- **Tier-aware data handling.** A dedicated `ChatGPT_Data_Handling_Notes.md` maps the Step 0 attestation gate to consumer Plus, Team, and Enterprise behavior, calls out the ChatGPT Memory protocol explicitly, and identifies the contractual boundaries that no in-prompt gate can substitute for.
- **Cost analysis pivoted** from per-token API billing (the model-agnostic baseline) to a wall-clock + analyst-hour model that fits how ChatGPT subscriptions actually bill, with optional Code Interpreter–based token estimation when a billing-grade view is wanted.
- **Cover-page rendering** delegates to Code Interpreter for styled PDFs, since inline base64 `<img>` tags do not render reliably in chat surfaces.

The model-agnostic v1 baseline of the toolkit lives in the sibling `OSAR v1/` and `security-impact-report/` folders.

## Who this is for

Security teams, GRC teams, and CISOs who already run on ChatGPT (Plus, Team, or Enterprise) and want a repeatable, AI-assisted process for producing security impact reports. The toolkit ships with placeholder tokens for organization-specific values; the in-chat configurator turns those tokens into a working Session Config in about five minutes.

## What's in the box

```
OSAR v1 - ChatGPT/
├── Custom_GPT_Instructions.txt                # paste this into the GPT Instructions field
├── Deployment_Guide.md                        # step-by-step Plus + Enterprise deployment
├── ChatGPT_Data_Handling_Notes.md             # tier-by-tier data handling reference
├── Security_Impact_Report_AI_Instructions.md  # the spec — uploaded as a knowledge file
├── modules/
│   ├── Module_Cost_Analysis.md
│   ├── Module_Infrastructure_Impact.md
│   ├── Module_NIST_800-53_Controls.md
│   ├── Module_POAM.md
│   ├── Module_Source_Code_Analysis.md
│   ├── Module_Vendor_Compliance.md
│   └── Module_WCAG_Accessibility.md
├── assets/
│   └── Cover_Logo_Base64.txt                  # neutral placeholder — replace with your own
├── examples/
│   ├── Example_Report_AcmeStateCyber.md       # fully-rendered sample using a fictional org
│   └── Example_Report_AcmeStateCyber.pdf      # styled PDF render of the same
├── config.example.yaml                        # full token list — uploaded as a knowledge file
├── configure.sh                               # power-user tool for pre-baking tokens (optional)
├── LICENSE                                    # Apache-2.0
├── SECURITY.md                                # vulnerability disclosure
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
└── CHANGELOG.md
```

## How it works

1. The user opens the Custom GPT in ChatGPT.
2. The GPT looks for a Session Config block in the user's first message. If none, it runs the in-chat configurator and emits one.
3. The user provides source material on the asset under review — a SOC 2 report, an architecture diagram, a vendor questionnaire, source code, etc.
4. The GPT runs Step 0 (sensitive-data gate), Step 1 (intake), Step 2 (analysis tasks A–G), then writes the full report in Step 3.
5. After delivery, the GPT offers six follow-up actions: styled PDF render, exec brief, NIST checklist, POA&M XLSX export, cost-comparison summary, and re-run with a different Session Config.

## Quick start

1. Read `Deployment_Guide.md` end-to-end — it's the canonical install instructions.
2. In ChatGPT, create a new Custom GPT (`Explore GPTs → Create`).
3. Paste the contents of `Custom_GPT_Instructions.txt` into the **Instructions** field.
4. Enable **Web Browsing** and **Code Interpreter & Data Analysis** in **Capabilities**.
5. Upload the spec, the seven modules, the cover-page logo, `config.example.yaml`, and the example report into **Knowledge** (11 files total).
6. Set the four conversation starters from the deployment guide.
7. Open a fresh thread, paste a Session Config block (or run the configurator), and try the example asset to validate.

## Configuration tokens

The source files use curly-brace tokens for every value an adopter is expected to localize. The full list lives in `config.example.yaml`. Selected examples:

| Token | What it replaces |
|---|---|
| `{ORGANIZATION}` | Full agency or company name |
| `{ORG_SHORT}` | Short label used in headers, footers, IDs |
| `{DIVISION}` | Sub-org (e.g., "Cyber Security Division") |
| `{MAINTAINER_NAME}`, `{MAINTAINER_TITLE}`, `{MAINTAINER_EMAIL}` | Document maintainer metadata |
| `{IR_CONTACT_EMAIL}` | Incident-response inbox |
| `{POLICY_REF:<topic>}` | Your internal policy number for that topic |
| `{STANDARD_REF:<topic>}` | Your internal standard number |
| `{IDP}`, `{MDM}`, `{EDR}`, `{VULN_SCANNER}`, `{TENANCY}`, `{HOSTING_ENV}` | Your security-tool stack |
| `{STATE_PRIVACY_LAW}`, `{STATE_ACCESSIBILITY_LAW}`, `{STATE_PUBLIC_RECORDS_LAW}` | Applicable jurisdictional statutes |
| `{VENDOR_SECURITY_ADDENDUM}` | Your procurement security exhibit |
| `{COLOR_PRIMARY}`, `{COLOR_ACCENT}` | Your brand colors |

Two paths to apply these:

- **Recommended for ChatGPT:** the in-chat configurator. The user runs it once per organization; the resulting `## SIR Session Config` block is pasted at the top of every new thread. The GPT applies the values to every {TOKEN} reference in the spec and modules at runtime.
- **Power-user path:** edit `config.yaml` locally and run `configure.sh` to produce a pre-substituted copy of the source files. Useful if you want to ship a pre-baked variant of the toolkit to your team. The script is unchanged from the model-agnostic v1 baseline.

## Important security notes for adopters

The Main Instructions file includes a **Step 0 attestation gate** that asks the AI to refuse processing of regulated data unless the user uploads a signed authorization block. This is a **procedural control, not authentication** — the model cannot cryptographically verify the attestation block and a determined bad-faith user can craft a fake one. Pair this gate with your organization's existing data-handling governance, your tier-appropriate ChatGPT tenancy (Team or Enterprise for any org that may handle regulated data), and your AI Acceptable Use Policy.

The default behavior on a *disputed* regulated-data finding is **refuse-and-escalate**, not proceed. Adjust this default only if your organization's governance explicitly permits.

See `ChatGPT_Data_Handling_Notes.md` for the full tier-by-tier breakdown.

## Origin and design philosophy

This toolkit was desgined by a public-sector CISO to enahnce the governance program and generalized for the open-source community. The hub-and-spoke structure is deliberate: it lets you adopt the modules you need, swap in your own, and keep the orchestrator stable across reports. The ChatGPT Edition is a tailored fork of the model-agnostic baseline — every change here is in service of the Custom GPT deployment surface.

## Contributing

See `CONTRIBUTING.md`. New analysis modules, jurisdictional law mappings, additional fully-rendered example reports, and ChatGPT-specific affordance recipes (Code Interpreter helpers, Web Browsing source maps) are especially welcome.

## License

Apache-2.0 — see `LICENSE`.
