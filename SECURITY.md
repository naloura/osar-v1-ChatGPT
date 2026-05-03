# Security Policy

## Reporting a vulnerability

If you discover a security issue in this toolkit — for example, a prompt-injection vector in the Custom GPT instructions or any module, a leaked credential in an example file, a flaw in the Step 0 attestation logic that could be exploited to bypass data-handling controls, or a Code Interpreter / Web Browsing affordance in a module that could be coerced into unsafe behavior — please report it privately rather than opening a public issue.

**Preferred channel:** [GitHub Security Advisories](https://docs.github.com/en/code-security/security-advisories/repository-security-advisories/about-repository-security-advisories) on this repository (Security tab → "Report a vulnerability"). This routes the report only to the maintainers and gives us a private space to coordinate a fix.

We aim to acknowledge reports within 5 business days and to publish a fix or mitigation within 30 days for high-severity issues.

## Scope

In scope:

- Prompt-injection vectors in `Custom_GPT_Instructions.txt`, the Main Instructions spec, or any module that could cause the GPT to leak data, bypass the Step 0 gate, or produce unsafe output
- Hard-coded secrets, credentials, internal hostnames, or PII in any file in this repository
- Logic flaws in the configuration substitution that could result in tokens leaking into rendered reports
- Vulnerabilities in `configure.sh`, the audit script, or any embedded Code Interpreter / Python snippet in a module that could be coerced into unsafe execution
- Misleading or inaccurate data-handling claims in `ChatGPT_Data_Handling_Notes.md`

Out of scope:

- The Step 0 attestation gate is documented as a *procedural* control, not authentication. The AI cannot cryptographically verify an attestation block. This is a known design limitation, not a vulnerability — adopters are expected to pair this gate with their own governance, tier-appropriate ChatGPT tenancy, and admin controls.
- ChatGPT platform behaviors (training-on-input policies, Memory implementation, retention windows) are OpenAI's responsibility and not ours to remediate. Report platform issues to OpenAI directly.
- Issues in third-party tools the toolkit references (Microsoft 365, CrowdStrike, Qualys, etc.) belong to those vendors.
- Issues in user-supplied configurations (`config.yaml`, Session Config blocks) are the adopter's responsibility.

## Disclosure preference

We follow coordinated disclosure. We'll work with you to publish a fix and CVE (if applicable) before any public discussion of the issue.
