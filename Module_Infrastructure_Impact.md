# Module — Infrastructure Impact Assessment (ChatGPT Edition)
**Module Type:** Context-aware — applies to all deployments; execute applicable subsections
**Trigger:** Always consulted; subsections activated based on Step 1 intake (browser-based → 5.4, server-hosted → 5.5, vendor SaaS → 5.6)
**Parent Document:** `Security_Impact_Report_AI_Instructions.md`
**Module Reference:** SIR-MOD-INFRA-001

---

## Analysis Task G — Client-Side and Server-Side Infrastructure Impact [CONTEXT-AWARE]

This analysis task is context-aware and applies differently depending on the asset type. Execute whichever sub-tasks apply.

**G.1 — Determine deployment architecture:**
- Is the asset browser-based (client-side rendering)? → Execute G.2
- Does the asset require server-side infrastructure (APIs, databases, compute)? → Execute G.3
- Is the asset a vendor SaaS solution (hosted externally)? → Execute G.4
- Does the asset impact both client and server? → Execute G.2 AND G.3

**G.2 — Client-Side Impact Assessment [CONDITIONAL — browser-based assets]:**
Evaluate the impact on end-user devices and browsers:
- Rendering performance (DOM complexity, animation, canvas/WebGL usage)
- Memory footprint (JavaScript heap, retained objects, media assets)
- CPU utilization during active use (idle vs interactive vs peak)
- Network call frequency and payload size during runtime
- Storage usage (localStorage, sessionStorage, IndexedDB, cookies)
- Browser compatibility and minimum requirements
- Impact on {ORG_SHORT}-managed devices ({MDM}, {EDR} sensor overhead)

**G.3 — Server-Side Impact Assessment [CONDITIONAL — server-hosted assets]:**
Evaluate the impact on {ORG_SHORT} enterprise infrastructure or hosting environment:
- Compute requirements (CPU, memory, GPU if applicable)
- Storage requirements (database size, file storage, log volume, growth rate)
- Network bandwidth (ingress/egress, API call volume, peak vs sustained)
- Scaling model (fixed capacity vs elastic, horizontal vs vertical)
- Dependency services (databases, message queues, caches, external APIs)
- High availability requirements (uptime SLA, failover, redundancy)
- Integration points with {ORG_SHORT} enterprise stack ({IDP}, {TENANCY}, SOC telemetry)
- Estimated monthly infrastructure cost (compute + storage + network)

**G.4 — Vendor SaaS Impact Assessment [CONDITIONAL — vendor-hosted solutions]:**
Even when the vendor hosts the solution, assess impact on {ORG_SHORT} infrastructure:
- Authentication load ({IDP} SSO calls, token refresh frequency)
- Network egress from {ORG_SHORT} to vendor (data volume, API call patterns)
- Agent or connector requirements on {ORG_SHORT} infrastructure (if any)
- Browser/client resource consumption for the vendor portal or dashboard
- Data residency and sovereign hosting requirements (GCC, FedRAMP boundary)

---

## Report Section 5 — Infrastructure Impact Subsections

These subsections are added to Section 5 of the report based on the asset's deployment architecture. Include whichever apply; omit those that do not and note "N/A — [reason]."

### 5.4 Client-Side Impact Assessment [CONDITIONAL — browser-based assets]

[Opening paragraph: describe the client-side footprint of the asset — what runs in the browser, how it affects the end-user device, and whether it interacts with state-managed device controls ({MDM}, {EDR}).]

| Impact Area | Measurement | Value | Assessment |
|---|---|---|---|
| Rendering performance | DOM complexity / animation / canvas | [VALUE] | [Low / Medium / High impact] |
| Memory footprint | JS heap / retained objects / media | [VALUE] | [Assessment] |
| CPU utilization | Idle / interactive / peak | [VALUE] | [Assessment] |
| Network calls at runtime | Frequency and payload | [VALUE] | [Assessment] |
| Client-side storage | localStorage / sessionStorage / IndexedDB / cookies | [VALUE or "None"] | [Assessment] |
| Browser compatibility | Minimum browser version | [VALUE] | [Compatible with {ORG_SHORT} standard image: Y/N] |
| MDM/EDR interaction | {MDM} compliance / {EDR} sensor overhead | [VALUE or "No conflict"] | [Assessment] |

### 5.5 Server-Side Impact Assessment [CONDITIONAL — server-hosted assets]

[Opening paragraph: describe the server-side footprint — what infrastructure is required, whether it runs on {ORG_SHORT}-managed infrastructure or vendor-hosted, and how it scales.]

| Impact Area | Requirement | Value | Assessment |
|---|---|---|---|
| Compute (CPU/Memory) | [Spec required] | [VALUE] | [Fits existing capacity: Y/N] |
| Storage | Database + file + log volume | [VALUE] | [Growth rate and projected 12-month need] |
| Network bandwidth | Ingress/egress, peak vs sustained | [VALUE] | [Assessment] |
| Scaling model | Fixed / elastic / horizontal / vertical | [VALUE] | [Assessment] |
| Dependency services | Databases, queues, caches, external APIs | [LIST] | [Risk assessment per dependency] |
| High availability | Uptime SLA, failover, redundancy | [VALUE] | [Assessment] |
| {ORG_SHORT} stack integration | {IDP}, {TENANCY}, SOC telemetry | [LIST] | [Integration complexity: Low/Med/High] |
| Est. monthly infra cost | Compute + storage + network | $[VALUE] | [Basis for estimate] |

### 5.6 Vendor SaaS Infrastructure Impact [CONDITIONAL — vendor-hosted solutions]

[Opening paragraph: even though the vendor hosts the solution, describe the impact on {ORG_SHORT} infrastructure from authentication, network traffic, agents, and client-side resource consumption.]

| Impact Area | Measurement | Value | Assessment |
|---|---|---|---|
| Authentication load | {IDP} SSO calls, token refresh | [VALUE] | [Assessment] |
| Network egress ({ORG_SHORT} → vendor) | Data volume, API patterns | [VALUE] | [Assessment] |
| Agent/connector on {ORG_SHORT} infra | Required: Y/N, resource footprint | [VALUE or "None"] | [Assessment] |
| Browser/client consumption | Portal resource usage | [VALUE] | [Assessment] |
| Data residency | GCC / FedRAMP boundary compliance | [VALUE] | [Meets requirement: Y/N] |

---

*Module — Infrastructure Impact (ChatGPT Edition) | Parent: Security_Impact_Report_AI_Instructions.md*
