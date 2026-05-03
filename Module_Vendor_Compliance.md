# Module — Vendor Compliance and Authorization (ChatGPT Edition)
**Module Type:** Conditional — vendor solutions only
**Trigger:** Step 1 intake identifies the asset as a vendor-provided solution (SaaS, managed service, COTS)
**Parent Document:** `Security_Impact_Report_AI_Instructions.md`
**Module Reference:** SIR-MOD-VENDOR-001

> **Web Browsing affordance:** if Web Browsing is enabled in this Custom GPT, verify each authorization claim against an authoritative source rather than relying on user-supplied vendor marketing collateral:
> - **FedRAMP / StateRAMP status:** `https://marketplace.fedramp.gov` (authoritative)
> - **SOC 2 reports:** the vendor's own trust portal (e.g., `trust.<vendor>.com`) — note that SOC 2 reports are typically NDA-gated; record whether the report is *available under NDA* vs *publicly attested*
> - **PCI DSS:** `https://www.pcisecuritystandards.org/assessors_and_solutions/qualified_security_assessors`
> - **DoD CC SRG (Impact Levels):** `https://public.cyber.mil/dccs/dccs-documents/`
>
> Always cite the source URL and the date you retrieved the information. If the vendor's claimed status cannot be verified, document the gap explicitly — do not silently accept the vendor's claim.

---

## Section 3 — Vendor Compliance and Authorization [CONDITIONAL — vendor solutions]

**Include for vendor SaaS or managed service solutions. Omit for internally developed assets.**

### 3.1 FedRAMP / StateRAMP Authorization Status

| Attribute | Value | Source |
|---|---|---|
| Authorization Level | [e.g., FedRAMP High / Moderate / None] | [marketplace.fedramp.gov entry / vendor PDF / unverified] |
| Authorization Status | [Authorized / In Process / N/A] | [URL or document reference, retrieved YYYY-MM-DD] |
| Cloud Service Provider | [e.g., AWS GovCloud / {HOSTING_ENV}] | [Source] |
| Continuous Monitoring | [Active / N/A] | [Source] |

### 3.2 Additional Certifications

| Certification | Status | Notes | Source |
|---|---|---|---|
| [e.g., DoD CC SRG IL2] | [Compliant / Certified / Attested] | [Details] | [URL or document, retrieved YYYY-MM-DD] |

### 3.3 {VENDOR_SECURITY_ADDENDUM}

| Requirement | Status | Evidence |
|---|---|---|
| Vendor MFA | [Verified / Pending] | [Per {VENDOR_SECURITY_ADDENDUM} and {POLICY_REF:vendor_security}] |
| FIPS 140-2/3 Encryption | [Verified / Pending] | [Per {STANDARD_REF:data_encryption}] |
| Security Questionnaire | [Complete / Pending] | [Details] |

---

## Vendor-Specific NIST SA Control Guidance

When this module applies, the following guidance applies to the SA (System and Services Acquisition) controls in the NIST Controls module:

**For vendor solutions:** Replace SA-8 through SA-15 with a reference to the vendor's SDLC documentation, penetration test report, SOC 2 Type II, or FedRAMP/StateRAMP authorization package. Confirm MFA per {VENDOR_SECURITY_ADDENDUM} and whether FIPS 140-2/140-3 validated encryption is in use per the {ORGANIZATION} Data Encryption Standard ({STANDARD_REF:data_encryption}).

---

*Module — Vendor Compliance (ChatGPT Edition) | Parent: Security_Impact_Report_AI_Instructions.md*
