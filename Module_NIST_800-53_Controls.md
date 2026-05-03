# Module — NIST 800-53 Rev 5 Controls Assessment (ChatGPT Edition)
**Module Type:** Required for all assessments
**Parent Document:** `Security_Impact_Report_AI_Instructions.md`
**Module Reference:** SIR-MOD-NIST-001

> **Web Browsing affordance:** if Web Browsing is enabled in this Custom GPT, you may verify the current published revision of NIST 800-53 (presently Rev 5) at `https://csrc.nist.gov/publications/detail/sp/800-53/rev-5/final` before producing this section. If a newer revision has superseded Rev 5, note it explicitly and ask the user whether to align the assessment to the new revision or retain Rev 5. Do not silently substitute.

---

## Analysis Task D — NIST 800-53 Rev 5 Control Assessment

For each control in Report Section 7, apply the decision logic below. Reference the applicable {ORG_SHORT} policy.

**AT-2 (Literacy Training and Awareness):** Training/awareness tool? If yes: Implemented — cite {ORG_SHORT} {POLICY_REF:awareness_training}. If no: assess or mark N/A.

**AT-3 (Role-Based Awareness Training):** Multiple roles presented? If yes: Implemented. If no: N/A or Process Dependent.

**CA-7 (Continuous Monitoring):** Code review or security assessment performed? If yes: Implemented (note date/method) — cite {POLICY_REF:topic} and {STANDARD_REF:security_operations}. Reassessment cadence defined? If not: Process Dependent.

**CA-8 (Penetration Testing):** Formal pen test? If yes: Implemented. If no and minimal attack surface: Process Dependent. Reference {POLICY_REF:risk_assessment}.

**CM-2 (Baseline Configuration):** SBOM documented? If yes: Implemented. If no: Process Dependent. Reference {POLICY_REF:authentication}.

**CM-3 (Configuration Change Control):** Change log or version history? If yes: Implemented. If no: Process Dependent. Reference {POLICY_REF:authentication}.

**CM-4 (Impact Analysis):** Changes reviewed for security impact? If yes: Implemented. If assumed: Process Dependent.

**CM-6 (Configuration Settings):** HTTP security headers configured (CSP, X-Content-Type-Options, X-Frame-Options, Referrer-Policy, HSTS)? If present: Implemented. If absent: **Configuration Required** — list missing headers. Reference {POLICY_REF:authentication}.

**CM-7 (Least Functionality):** Unnecessary backend/APIs/debug endpoints? If none: Implemented. If present: Process Dependent.

**CM-8 (System Component Inventory):** SBOM available? If yes: Implemented. Vendor without SBOM: Process Dependent.

**CP-9 (System Backup):** Version control or backup? If yes: Implemented. If assumed: Process Dependent.

**CP-10 (System Recovery):** Can system be fully restored? If trivial (static): Implemented. If complex: Process Dependent until documented.

**IR-6 (Incident Reporting):** Vulnerability reporting process defined? Reference {POLICY_REF:access_control}. Enterprise IR covers it: Process Dependent (confirm SOC escalation path).

**RA-2 (Security Categorization):** Classification from data scan using {ORG_SHORT} Data Classification Matrix? No regulated data: Public/Private → Implemented. Regulated data: appropriate {ORG_SHORT} label → Implemented with PIA note. Reference {POLICY_REF:program_management}.

**RA-3 (Risk Assessment):** This report is the artifact: Implemented.

**RA-5 (Vulnerability Scanning):** Code review or scan performed? If yes: Implemented. No dynamic surface (static): note and mark Implemented. Reference {POLICY_REF:risk_assessment} and {POLICY_REF:program_management} ({VULN_SCANNER} mandate).

**RA-7 (Risk Response):** Risk decisions documented: Implemented.

**SA-8 (Security Engineering Principles):** No `eval()`, no dynamic code loading, `'use strict'`, data minimization, FIPS crypto per {STANDARD_REF:data_encryption}? If present: Implemented. If missing: Process Dependent.

**SA-10 (Developer Configuration Management):** Change log and version control? If yes: Implemented. If assumed: Process Dependent.

**SA-11 (Developer Testing):** Testing performed? If yes: Implemented with details. If no evidence: Process Dependent. Reference {POLICY_REF:incident_response}.

**SA-15 (Development Process):** Coding standards documented or evident? If yes: Implemented. If no evidence: Process Dependent.

**SC-18 (Mobile Code):** All JS from same origin, no third-party scripts, CSP `script-src 'self'` compatible? If yes: Implemented. Third-party scripts: note each and assess risk.

**SC-28 (Protection of Information at Rest):** Data stored? If no: N/A. If yes: assess against {STANDARD_REF:data_encryption} — AES-256 required, FIPS 140-2/3 modules required.

**SI-2 (Flaw Remediation):** Vulnerability process? Enterprise IR: Process Dependent. Defined: Implemented. Reference {POLICY_REF:configuration_mgmt}.

**SI-3 (Malicious Code Protection):** No `eval()`, no dynamic injection, no user-controlled innerHTML? If yes: Implemented. If any with user input: flag for remediation.

**SI-7 (Software Integrity):** Verifiable baseline (SBOM, hash, VCS)? If yes: Implemented. If no: Process Dependent.

**SI-10 (Input Validation):** Free-text user input? If no: Implemented by design. If yes: describe validation and sufficiency.

---

## Report Section 7 — NIST 800-53 Rev 5 Controls Assessment [REQUIRED]

### 7.1 Scope and Inherited Controls

[Paragraph: application-layer scope; enterprise controls excluded.]

**Worked example below — replace each row with the inheritance pattern that applies in *your* environment.** The "Inherited From" column should name the enterprise system that satisfies that control family on behalf of this asset; the "Org Policy / Standard" column should cite your organization's own policy library. The values shown use the placeholder tokens defined in `config.example.yaml`.

| Control Family | Inherited From (example) | Org Policy / Standard | Basis |
|---|---|---|---|
| AC — Access Control | {ENTERPRISE_COLLAB} / {TENANCY} | {POLICY_REF:access_control} | Role-based access; no external/guest users |
| AT — Awareness and Training | Enterprise security training program | {POLICY_REF:awareness_training} | Annual training requirement |
| AU — Audit and Accountability | {COMPLIANCE_PLATFORM} / {ORG_SHORT} SOC | {POLICY_REF:audit_accountability} / {STANDARD_REF:security_operations} | Platform logging; SOC 24×7 monitoring |
| CA — Assessment, Authorization, Monitoring | {ORG_SHORT} GRC program | {POLICY_REF:risk_assessment} / {STANDARD_REF:security_operations} | Continuous monitoring program |
| CM — Configuration Management | Enterprise change-management process | {POLICY_REF:configuration_mgmt} | Change control and baseline management |
| CP — Contingency Planning | Enterprise BCP/DR program | {POLICY_REF:contingency} | Business continuity, backups, DR testing |
| IA — Identification and Authentication | {IDP} | {POLICY_REF:identification_authentication} | Enterprise IAM; MFA per {VENDOR_SECURITY_ADDENDUM} |
| IR — Incident Response | {ORG_SHORT} SOC / IR team | {POLICY_REF:incident_response} | Enterprise IR plan and SOC escalation |
| MP — Media Protection | DLP / {COMPLIANCE_PLATFORM} | {POLICY_REF:data_governance} | Enterprise media classification and handling |
| PE — Physical and Environmental | {HOSTING_ENV} infrastructure | {POLICY_REF:contingency} | Cloud provider data-center controls |
| PL — Planning | {DIVISION} | {POLICY_REF:program_management} | Enterprise security planning |
| PM — Program Management | {ORG_SHORT} / Division CISO | {POLICY_REF:program_management} | Enterprise program governance |
| PS — Personnel Security | HR / {ORG_SHORT} | {POLICY_REF:identification_authentication} | Personnel vetting and onboarding/offboarding |
| PT — PII Processing | [N/A if no PII — cite Sec 6.3] | N/A | [Per regulated data scan] |
| RA — Risk Assessment | {ORG_SHORT} GRC program | {POLICY_REF:risk_assessment} | This report; periodic reassessment |
| SC (network) — System and Communications | Enterprise network / {TENANCY} | {POLICY_REF:audit_accountability} | Firewall, segmentation, HTTPS, VPN |
| SI — System and Information Integrity | {EDR} / patching program | {POLICY_REF:configuration_mgmt} | Endpoint protection and flaw remediation |

**For vendor SaaS:** substitute the vendor's inherited controls from their SOC 2 Type II report, FedRAMP authorization package, or StateRAMP authorization rather than your own enterprise stack. Document the authorization boundary explicitly. If Web Browsing is enabled, you may verify the vendor's current FedRAMP or StateRAMP status at `https://marketplace.fedramp.gov` and cite the source URL in your finding.

**For self-hosted assets in commercial cloud:** the PE family is inherited from the cloud provider (AWS / Azure / GCP) and the AC/IA/AU families remain your organization's responsibility.

Adjust the "Inherited From" column to reflect your actual hosting environment and tooling.

### 7.2 Application-Layer Controls

Status values:
- ✅ **Implemented** — satisfied by design or deployment
- ⚠️ **Process Dependent** — assumed organizational process; confirm it exists
- 🔧 **Configuration Required** — deployment-time setting needed; document action

---

**AT — Awareness and Training** *({POLICY_REF:awareness_training})*

| Control ID | Control Name | Application Relevance | Status | Evidence / Notes |
|---|---|---|---|---|
| AT-2 | Literacy Training and Awareness | How the asset delivers or supports security awareness training; cite {POLICY_REF:awareness_training} if asset is a training tool | [STATUS] | [Evidence — describe training content, target audience, and whether the asset itself constitutes a training delivery mechanism] |
| AT-3 | Role-Based Awareness Training | Whether the asset presents content from multiple organizational roles or job functions | [STATUS or N/A] | [Evidence — describe role coverage or explain N/A basis] |

---

**CA — Assessment, Authorization, and Monitoring** *({POLICY_REF:risk_assessment} / {STANDARD_REF:security_operations})*

| Control ID | Control Name | Application Relevance | Status | Evidence / Notes |
|---|---|---|---|---|
| CA-7 | Continuous Monitoring | Periodic review of the asset for security issues introduced by updates or dependency changes; {ORG_SHORT} SOC provides 24×7 enterprise monitoring per the {STANDARD_REF:security_operations} | [STATUS] | [Description of review cadence and whether {ORG_SHORT} SOC covers this asset's telemetry] |
| CA-8 | Penetration Testing | Adversarial testing appropriate to the asset's risk level and attack surface | [STATUS] | [Scope, method, date — or note low priority if attack surface is minimal (static files, no backend)] |

---

**CM — Configuration Management** *({POLICY_REF:authentication})*

| Control ID | Control Name | Application Relevance | Status | Evidence / Notes |
|---|---|---|---|---|
| CM-2 | Baseline Configuration | Documented baseline of all software components | [STATUS] | [Reference to SBOM section — Section 6.7] |
| CM-3 | Configuration Change Control | Review and approval process for changes before deployment | [STATUS] | [Change log reference or process description] |
| CM-4 | Impact Analysis | Security review of proposed changes before application — evidence that changes were reviewed for security impact before deployment | [STATUS] | [Process description — or "Process Dependent" if assumed but not documented] |
| CM-6 | Configuration Settings | Security-relevant settings at the server or CDN layer: HTTP response headers (CSP, X-Content-Type-Options, X-Frame-Options, Referrer-Policy, HSTS), HTTPS enforcement | [STATUS] | [List required headers and current state — see CM-6 action block below] |
| CM-7 | Least Functionality | Application exposes only the features required for its purpose — no unnecessary services, APIs, or capabilities | [STATUS] | [Describe what is absent: no backend, no admin panel, no debug endpoints, etc.] |
| CM-8 | System Component Inventory | Complete inventory of all components, libraries, and dependencies (SBOM) | [STATUS] | [Reference to SBOM section — Section 6.7. If vendor: note whether vendor publishes a SBOM] |

> **CM-6 Action — Required HTTP Security Headers** (document if Configuration Required — apply at hosting layer):
> ```
> Content-Security-Policy: [DEFINE APPROPRIATE POLICY — e.g., default-src 'self'; script-src 'self']
> X-Content-Type-Options: nosniff
> X-Frame-Options: SAMEORIGIN
> Referrer-Policy: no-referrer
> Strict-Transport-Security: max-age=31536000; includeSubDomains
> ```

---

**CP — Contingency Planning**

| Control ID | Control Name | Application Relevance | Status | Evidence / Notes |
|---|---|---|---|---|
| CP-9 | System Backup | Source files and configuration are maintained in version control or backup | [STATUS] | [Backup location, frequency, and retention policy] |
| CP-10 | System Recovery and Reconstitution | Process for restoring the asset to a known-good state after an incident | [STATUS] | [Describe recovery steps and estimated time to restore — e.g., "Redeploy from version control in <30 minutes"] |

---

**IR — Incident Response** *({POLICY_REF:access_control} / {STANDARD_REF:security_operations})*

| Control ID | Control Name | Application Relevance | Status | Evidence / Notes |
|---|---|---|---|---|
| IR-6 | Incident Reporting | Process for reporting vulnerabilities or security events in the asset to the {ORG_SHORT} SOC and IR team | [STATUS] | [Contact point: {IR_CONTACT_EMAIL} / {ORG_SHORT} Service Desk; escalation path per {POLICY_REF:access_control} and {STANDARD_REF:security_operations}] |

---

**RA — Risk Assessment** *({POLICY_REF:program_management} / {POLICY_REF:risk_assessment})*

| Control ID | Control Name | Application Relevance | Status | Evidence / Notes |
|---|---|---|---|---|
| RA-2 | Security Categorization | Formal classification of the asset using the {ORG_SHORT} Data Classification Matrix (IAL1/IAL2 framework) | [STATUS] | [Classification label and reference to Section 6.6] |
| RA-3 | Risk Assessment | Documented assessment of risks from operating the asset | [STATUS] | [Reference to this report as the artifact; governed by {POLICY_REF:program_management}] |
| RA-5 | Vulnerability Monitoring and Scanning | Code review, static analysis, or dynamic scanning appropriate to the asset; {VULN_SCANNER} used for enterprise vulnerability management per {POLICY_REF:program_management} | [STATUS] | [Tools used, date of last review, and whether {VULN_SCANNER} scan was performed] |
| RA-7 | Risk Response | Documented decisions about identified risks — mitigate, accept, transfer, or avoid | [STATUS] | [Risk decisions and any open items requiring follow-up] |

---

**SA — System and Services Acquisition** *({POLICY_REF:incident_response})*

| Control ID | Control Name | Application Relevance | Status | Evidence / Notes |
|---|---|---|---|---|
| SA-8 | Security and Privacy Engineering Principles | Security principles applied during design: least privilege, data minimization, fail-safe defaults, no `eval()`, no dynamic code loading, `'use strict'` enforcement | [STATUS] | [List principles applied and how — cite FIPS 140-2/3 if crypto is in scope per {STANDARD_REF:data_encryption}] |
| SA-10 | Developer Configuration Management | Source code under version control; changes traceable to a change log | [STATUS] | [Version control system and change log reference] |
| SA-11 | Developer Testing and Evaluation | Testing and code review performed prior to deployment (syntax check, code review, unit tests, integration tests) | [STATUS] | [Describe tests performed and findings] |
| SA-15 | Development Process, Standards, and Tools | Development follows documented coding standards and security practices (module pattern, strict mode, consistent style) | [STATUS] | [Standards applied — e.g., OWASP, language-specific guidelines] |

**For vendor solutions:** Replace SA-8 through SA-15 with a reference to the vendor's SDLC documentation, penetration test report, SOC 2 Type II, or FedRAMP/StateRAMP authorization package. Confirm MFA per {VENDOR_SECURITY_ADDENDUM}.

---

**SC — System and Communications Protection (Application Layer)** *({POLICY_REF:audit_accountability} / {STANDARD_REF:data_encryption})*

| Control ID | Control Name | Application Relevance | Status | Evidence / Notes |
|---|---|---|---|---|
| SC-18 | Mobile Code | Control over JavaScript or other mobile code; only trusted, origin-controlled code executes. Assess: Does all JS come from the same origin? Are there third-party scripts? Can CSP `script-src 'self'` be applied? | [STATUS] | [Describe third-party script inventory; note CSP posture] |
| SC-28 | Protection of Information at Rest | Sensitive data stored by the application is encrypted using AES-256 with a FIPS 140-2 or FIPS 140-3 validated module per {STANDARD_REF:data_encryption} | [STATUS or N/A] | [If N/A: "No data stored at rest." If applicable: confirm AES-256 and FIPS-validated module] |

---

**SI — System and Information Integrity** *({POLICY_REF:configuration_mgmt})*

| Control ID | Control Name | Application Relevance | Status | Evidence / Notes |
|---|---|---|---|---|
| SI-2 | Flaw Remediation | Process for identifying, tracking, and correcting discovered vulnerabilities; remediation SLA per {POLICY_REF:access_control} | [STATUS] | [Remediation process description and SLA] |
| SI-3 | Malicious Code Protection | Measures preventing malicious code execution or injection through the asset; {EDR} provides enterprise endpoint protection | [STATUS] | [Describe: no eval(), CSP, input handling, {EDR} coverage] |
| SI-7 | Software, Firmware, and Information Integrity | Verification that software has not been tampered with since baseline | [STATUS] | [Integrity verification method — hash, version control, SBOM comparison] |
| SI-10 | Information Input Validation | All user inputs are validated before processing | [STATUS] | [Describe input validation — or note "No user input accepted by design" if applicable] |

---

### 7.3 Control Summary Table

| Control Family | Assessed | Implemented | Process Dep. | Config Req. | N/A |
|---|---|---|---|---|---|
| AT | [N] | [N] | [N] | [N] | [N] |
| CA | [N] | [N] | [N] | [N] | [N] |
| CM | [N] | [N] | [N] | [N] | [N] |
| CP | [N] | [N] | [N] | [N] | [N] |
| IR | [N] | [N] | [N] | [N] | [N] |
| RA | [N] | [N] | [N] | [N] | [N] |
| SA | [N] | [N] | [N] | [N] | [N] |
| SC | [N] | [N] | [N] | [N] | [N] |
| SI | [N] | [N] | [N] | [N] | [N] |
| **Total** | **[N]** | **[N]** | **[N]** | **[N]** | **[N]** |

[List open Config Required and Process Dependent items with responsible party and target date.]

---

*Module — NIST Controls (ChatGPT Edition) | Parent: Security_Impact_Report_AI_Instructions.md*
