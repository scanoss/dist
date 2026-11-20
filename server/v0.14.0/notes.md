# Earnie v0.14.0

Released 2026-11-20.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.14.0`
- `ghcr.io/scanoss/earnie/earnie-web:v0.14.0`

<!-- earnie:stable-changes -->
## Changes since v0.13.0

For an admin moving from v0.13.0 to v0.14.0.

### Weekly releases included

- v0.14.0

### What's new

**API**

- A concluded license carries its category and decides the component's
- Set and clear a component's concluded license
- License component detail read
- Identified models expose match provenance and verdict, model enrichment its bias source

**Agenttext**

- Add Clean for tenant code handed to an agent

**Authentication**

- Rotate an API key with a grace period

**Command-line client**

- Earnie export -o, -o - to stdout, and SARIF examples in --help
- Earnie export --bom-format sarif
- Filter findings by severity, any facet, a pull request's new findings and source; list the facets
- Add earnie findings list, show and export
- Author policies from the terminal with earnie policy
- Project create --if-not-exists, slug suggestions, help examples
- Add earnie project list, show, create and update

**Crypto**

- The finding sheet shows the asset, the other algorithms at its line and the way in

**Findings**

- Earnie_get_finding names a model's licence lineage and ancestors
- Carry a model's ancestors on its enrichment

**Integrations**

- List the branches of a connected repository

**MCP and agents**

- Earnie_check_policy and every problem in a refused try
- Earnie_save_policy and earnie_delete_policy
- Read the policy vocabulary and the organization's policies
- Serve a policy-authoring prompt over prompts/list and prompts/get
- Tell agents how to work with Earnie in initialize instructions

**Notifications**

- Scan_completed kind for webhook-driven CI and SIEM

**Policies**

- Say when a keyed create replayed, so the CLI reports already_exists
- Check a draft over REST and describe each catalog field
- Check a draft for every problem, not the first
- Describe every catalog field and resolve its CEL path
- Notify org admins when a policy's agent rule changes
- Refuse a save that sets name, description or agent_rule over its length limit
- Frame the managed block's rule lines as descriptions, not commands
- A copyleft ancestor conflicts with any non-copyleft model licence
- Warn on a model licensed more permissively than its lineage
- Compare a model's licence with its lineage's in policy fields
- License policies read a component's concluded license
- Rank model licence categories and compare a model with its ancestors

**Projects**

- Let an API key with projects:import import repositories
- Scan a chosen branch on import and connect

**Reports**

- A SARIF 2.1.0 export of a snapshot's findings

**Review**

- Resolving no longer asks for a concluded license

**SBOM export**

- Seed, e2e-real spec, verify features and changelog for the transitive dependencies option
- Freeze and accept include_transitive_dependencies across the API, estate export and MCP
- Omit declared transitive dependencies on request
- Add include_transitive_dependencies to the export contract
- Name each AIBOM ancestor with its own license
- Export reads the component's concluded license

**Scans**

- Fetch ancestor model records
- Walk a model's lineage breadth-first
- List one crypto asset row's findings and its findings per library
- Concluded license on the component, with backfill
- A library row carries its post-quantum support from the dataset
- Keep the provenance and verdict the AI scanners already send
- Keep the provenance, verdict and bias source the AI scanners already send

**Triage**

- Serve a model's ancestors and its licence lineage verdict

**Web interface**

- Offer projects:import as an Import grant on API keys
- Offer the scan_completed kind in notification rules, seed one
- Add the include transitive dependencies toggle to the export sheets
- Pick the branch to scan on the New scan page
- The model lineage rail shows each ancestor's licence and the conflict
- Conclude a component's license from the Licenses rail
- The Assets rail says what an asset is, where it is, and lists its findings
- Licenses component rail
- The Libraries rail says the next step, groups assets by status and lists findings by place
- One status legend and one Migration column for the crypto tables
- Less text, wave 4: onboarding, shared dialogs and leftovers
- Less text, wave 2: dashboards, scan run, inventories and exports
- Less text, wave 1b: scan configuration, integrations, notifications and SSO
- Rail lines show the effective migration priority
- Noto Sans titles and numerals, and the onboarding pane back on its sheet
- The crypto finding sheet shows its route's values, confidence and entry
- The crypto finding sheet and rails say each fact once
- Undo a Wrong detection from the Cryptography page
- Severity in the Assets rail and open findings in the Libraries rail
- List an asset's open findings in the Cryptography rail and open them in the finding sheet
- Open a Needs attention finding in a sheet on the Cryptography overview

**General**

- Project Licenses inventory, slice 1 (read, page, grouped table)

### Fixes

**API**

- A pull request scan that introduced a component dates its first sighting

**Command-line client**

- Export -o - with --format json keeps stderr one JSON document
- Findings walks drop repeated findings and say when the set changed
- Findings show prints the evidence; --format csv names --file-format
- Project create conflict says whether the name or slug is taken; an archived slug is never reused

**Database**

- Drop the rotated_from index; api_keys is too small to need one

**MCP and agents**

- Offer the policy prompt only to keys that can dry-run, and say how to attach without policies:write

**Notifications**

- An email channel refuses a scan_completed rule and the dialog hides it

**Policies**

- Replay a keyed create that names its slug instead of answering slug_taken
- Describe the AI lineage fields main added, and stop pinning the field count
- Keep a policy's line breaks in the list text, in a fenced CEL block
- Return the refused field and limit, and say them in the editor's language
- Size the agent-text caps in bytes from the rune save limits
- Sanitise tenant policy prose on every path that hands it to an agent
- A model the knowledge base did not find reads unverified

**Projects**

- A purge cascades the project's concluded licenses

**Reports**

- Validate the SARIF log against the 2.1.0 schema and rank alerts without a CVSS score

**Review**

- Keep the Open list visible under a long Resolved list

**SBOM export**

- SARIF keeps crypto inventory in the CBOM and caps a run at 25,000 results

**Scans**

- Sanitise the policy name earnie_review_code hands to an agent
- A wrong-case parent spelling no longer hides a right one
- Queue a conclusion's policy evaluation on its own transaction
- Split a row's findings on the status facet's decided states
- A qualified or subpath purl keeps its concluded license in the backfill
- Run dependency-build JVMs without the Base64 intrinsic (Java4Shell)
- Hold the provenance and verdict writer for the next release

**Triage**

- A resolve that changes a component's conclusion audits it under the store's lock

**Web interface**

- A divider separates each policy in a finding's Policy section
- The model strip fills its width and the model card reads quieter
- A low confidence band is the Confidence cell's word, not a sentence too
- A model leaves out an unknown size and source-managed weights
- A license source filter reads as a word, not the API's value
- A concluded license does not rank its group with a verdict it did not get
- The rail reads findings:write through PERMISSIONS
- Who concluded a license reads on its own line in the narrow cell
- The rail says which ids a concluded license takes
- The Where hint is one translated message, not two joined fragments
- The Libraries brief drops its Migrate by year; dates stay in the legend and the finding sheet
- A Where row shows its library's migration only beside a quantum-vulnerable asset
- The Assets rail's priority line drops the year; dates stay in the legend and the finding sheet
- Key the rail's finding reads under pages so a priority change refreshes them
- A rail fact names its source only when the cell label does not
- Rail text buttons line up with the text above them
- Even spacing around the dot between a library's version and how it comes in
- The crypto status legend works on a phone
- The Vulnerable line names the 2030 to 2035 window, not one year
- A Needs attention route tells a screen reader how many libraries it crosses
- The severity chart keeps its labels on hover and shows the breakdown of a part

### Upgrade steps

**Review before upgrading:**

- 8 database migration(s) run on start and `install.sh` does not reverse them: take the backup first, and roll back by restoring it.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.14.0`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

No keys added, changed or removed.

### Database migrations

8 new, applied in order by the `migrate` service on start.

**`0154_crypto_migration_overrides`**

```sql
CREATE TABLE public.crypto_migration_overrides (
    id            BIGINT      GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    org_id        UUID        NOT NULL REFERENCES public.organizations(id),
    project_id    UUID        NOT NULL REFERENCES public.projects(id) ON DELETE RESTRICT,
    identity_hash TEXT        NOT NULL CHECK (identity_hash <> ''),
    finding_id    UUID        NOT NULL,
    kind          TEXT        NOT NULL CHECK (kind IN ('priority', 'accepted_risk', 'postponed', 'cleared')),
    level         TEXT        CHECK (level IN ('P1', 'P2', 'P3')),
    until         DATE,
    comment       TEXT        NOT NULL DEFAULT '',
    actor_kind    TEXT        NOT NULL CHECK (actor_kind IN ('user', 'api_key')),
    actor_id      UUID        NOT NULL,
    actor_display TEXT        NOT NULL DEFAULT '',
    request_id    UUID        NOT NULL,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT crypto_migration_overrides_level CHECK ((kind = 'priority') = (level IS NOT NULL)),
    CONSTRAINT crypto_migration_overrides_until CHECK ((kind = 'postponed') = ("until" IS NOT NULL)),
    CONSTRAINT crypto_migration_overrides_comment CHECK (kind = 'cleared' OR btrim(comment) <> '')
);

CREATE INDEX crypto_migration_overrides_latest
    ON public.crypto_migration_overrides (project_id, identity_hash, id DESC);

CREATE TABLE public.crypto_migration_override_requests (
    org_id        UUID        NOT NULL REFERENCES public.organizations(id),
    request_id    UUID        NOT NULL,
    project_id    UUID        NOT NULL,
    identity_hash TEXT        NOT NULL,
    fingerprint   TEXT        NOT NULL,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (org_id, request_id)
);

CREATE FUNCTION public.crypto_migration_overrides_append_only() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    RAISE EXCEPTION '% is append-only', TG_TABLE_NAME USING ERRCODE = 'integrity_constraint_violation';
END $$;

CREATE TRIGGER crypto_migration_overrides_append_only
    BEFORE UPDATE OR DELETE ON public.crypto_migration_overrides
    FOR EACH ROW EXECUTE FUNCTION public.crypto_migration_overrides_append_only();

CREATE TRIGGER crypto_migration_override_requests_append_only
    BEFORE UPDATE OR DELETE ON public.crypto_migration_override_requests
    FOR EACH ROW EXECUTE FUNCTION public.crypto_migration_overrides_append_only();
```

**`0155_projects_import_permission`**

```sql
UPDATE roles
SET permissions = array_append(permissions, 'projects:import')
WHERE name IN ('admin', 'operator')
  AND is_system = TRUE
  AND NOT ('projects:import' = ANY(permissions));
```

**`0156_import_batch_api_key`**

```sql
ALTER TABLE public.project_import_batches
  ADD COLUMN created_by_api_key_id UUID;
```

**`0157_api_key_rotated_from`**

```sql
ALTER TABLE public.api_keys
    ADD COLUMN rotated_from_id UUID REFERENCES public.api_keys (id) ON DELETE SET NULL;
```

**`0010_agent_rule_changed_kind`**

```sql
ALTER TABLE notifications.notifications DROP CONSTRAINT notifications_kind_class;
ALTER TABLE notifications.notifications ADD CONSTRAINT notifications_kind_class CHECK (
    (kind IN ('kev_exposure', 'cra_deadline', 'new_vulnerability') AND class = 'security') OR
    (kind IN ('gate_failed', 'approval_requested', 'approval_decided', 'agent_rule_changed') AND class = 'policy') OR
    (kind IN ('member_added', 'release_available') AND class = 'account')
);

ALTER TABLE notifications.notification_rules DROP CONSTRAINT notification_rules_kinds;
ALTER TABLE notifications.notification_rules ADD CONSTRAINT notification_rules_kinds CHECK (
    (class = 'security' AND kinds <@ ARRAY['kev_exposure', 'cra_deadline', 'new_vulnerability']) OR
    (class = 'policy'   AND kinds <@ ARRAY['gate_failed', 'approval_requested', 'approval_decided', 'agent_rule_changed']) OR
    (class = 'account'  AND kinds <@ ARRAY['member_added', 'release_available'])
);
```

**`0011_scan_completed_kind`**

```sql
ALTER TABLE notifications.notifications DROP CONSTRAINT notifications_kind_class;
ALTER TABLE notifications.notifications ADD CONSTRAINT notifications_kind_class CHECK (
    (kind IN ('kev_exposure', 'cra_deadline', 'new_vulnerability') AND class = 'security') OR
    (kind IN ('gate_failed', 'approval_requested', 'approval_decided', 'agent_rule_changed', 'scan_completed') AND class = 'policy') OR
    (kind IN ('member_added', 'release_available') AND class = 'account')
);

ALTER TABLE notifications.notification_rules DROP CONSTRAINT notification_rules_kinds;
ALTER TABLE notifications.notification_rules ADD CONSTRAINT notification_rules_kinds CHECK (
    (class = 'security' AND kinds <@ ARRAY['kev_exposure', 'cra_deadline', 'new_vulnerability']) OR
    (class = 'policy'   AND kinds <@ ARRAY['gate_failed', 'approval_requested', 'approval_decided', 'agent_rule_changed', 'scan_completed']) OR
    (class = 'account'  AND kinds <@ ARRAY['member_added', 'release_available'])
);
```

**`0015_include_transitive_dependencies`**

```sql
ALTER TABLE sbom.snapshots
    ADD COLUMN include_transitive_dependencies BOOLEAN NOT NULL DEFAULT TRUE;
```

**`0083_component_concluded_licenses`**

```sql
CREATE TABLE scans.component_concluded_licenses (
    project_id     UUID        NOT NULL REFERENCES public.projects(id) ON DELETE CASCADE,
    component_id   UUID        NOT NULL REFERENCES scans.components(id) ON DELETE CASCADE,
    spdx_id        TEXT        NOT NULL CHECK (spdx_id <> '' AND length(spdx_id) <= 256),
    set_by_kind    TEXT        NOT NULL,
    set_by_id      UUID        NOT NULL,
    set_by_display TEXT        NOT NULL DEFAULT '',
    set_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (project_id, component_id)
);

INSERT INTO scans.component_concluded_licenses
    (project_id, component_id, spdx_id, set_by_kind, set_by_id, set_by_display, set_at)
SELECT DISTINCT ON (f.project_id, c.id)
       f.project_id,
       c.id,
       btrim(r.concluded_license),
       r.resolved_by_actor_kind,
       r.resolved_by_actor_id,
       COALESCE(
           (SELECT u.email FROM public.users u WHERE u.id = r.resolved_by_actor_id),
           (SELECT k.name FROM public.api_keys k WHERE k.id = r.resolved_by_actor_id),
           ''),
       r.created_at
FROM public.resolutions r
JOIN public.findings f ON f.id = r.finding_id AND f.resolution_id = r.id
CROSS JOIN LATERAL (SELECT substring(r.scope_value FROM '^[^?#]*') AS base,
                           COALESCE(substring(r.scope_value FROM '[?#].*$'), '') AS tail) p
JOIN scans.components c
  ON c.purl = regexp_replace(p.base, '@[^@/]*$', '') || p.tail
 AND COALESCE(c.version, '') = COALESCE((regexp_match(p.base, '@([^@/]*)$'))[1], '')
WHERE r.scope_kind = 'purl'
  AND r.status <> 'reverted'
  AND btrim(COALESCE(r.concluded_license, '')) <> ''
ORDER BY f.project_id, c.id, r.created_at DESC, r.id DESC
ON CONFLICT (project_id, component_id) DO NOTHING;
```

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

No dependency or toolchain bump between v0.13.0 and v0.14.0.

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.13.0 and v0.14.0 is marked as a security fix.
<!-- /earnie:stable-changes -->

