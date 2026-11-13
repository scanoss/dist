# Earnie v0.12.0

<!-- earnie:stable -->
**v0.12.0 is a stable release.** Promoted on 2026-11-13. Upgrade test: https://github.com/scanoss/earnie/actions/runs/43440645462. Supported until the second stable release after it is promoted.
<!-- /earnie:stable -->

Released 2026-11-13.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.12.0`
- `ghcr.io/scanoss/earnie/earnie-web:v0.12.0`

<!-- earnie:stable-changes -->
## Changes since v0.11.4

For an admin moving from v0.11.4 to v0.12.0.

### Weekly releases included

- v0.11.5
- v0.11.6
- v0.11.7
- v0.11.8
- v0.12.0

### What's new

**Crypto**

- Derive and show the PQC migration path of each vulnerable finding
- Add the hybrid post-quantum status
- Take the post-quantum verdict from the shared PQC dataset

**Notifications**

- Notify a new vulnerability on a component a project already has

**Scans**

- Export vulnerability refresh metrics and skip unchanged rows in the upsert
- Refresh the inventory's vulnerabilities daily between scans

**Vulnerabilities**

- Import OpenVEX and CycloneDX VEX as statements (backend + CLI)

**Web interface**

- Import a VEX document on the Vulnerabilities page

### Fixes

**Crypto**

- Group a hybrid under its own name, not its post-quantum half
- Keep the hybrid a post-quantum family is paired with, on PQC dataset 1.1.0
- Move the risk table vintage to nist-2026-11 for the dataset's verdicts
- Take the post-quantum verdict from the family the table resolves
- Resolve the RSAES-OAEP and RSAES-PKCS1 spellings to RSA

**Dev**

- Run the dependency sandbox on arm64 macOS hosts

**MCP and agents**

- Say when earnie_review_code could not read a submitted manifest

**Purl**

- Keep Gradle dynamic versions unpinned on pkg:maven
- Keep a Maven version's qualifier as part of its pin

**SBOM export**

- Carry the console's licences into exports and report copyleft for every GNU spelling

**Scans**

- Stored posture after the seed, and a posture write never deadlocks the pool
- Say which manifest ecosystems crypto dependency scanning left unchecked
- Stop concurrent scans deadlocking the licences stage
- Trust an answer's position only when nothing is missing
- Keep a maintainer signal of any shape the API sends
- Complete a scan degraded when a requested scanner cannot run here
- Keep file contents and AI matching on the SCANOSS API by default
- Backfill snapshot licences as the catalogue stood at capture
- Keep supplier SBOM licences out of the snapshot's catalogue fallback

**Verify**

- Judge page timings on the least disturbed load

**Web interface**

- Name a run's enrichments in its Configuration section
- Resolve minimatch 11.0.5 to clear the globparts DoS advisory
- Cancel the / keystroke that opens the project switcher

### Upgrade steps

**Review before upgrading:**

- 8 database migration(s) run on start and `install.sh` does not reverse them: take the backup first, and roll back by restoring it.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.12.0`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

**Added**

- `EARNIE_VULNERABILITY_REFRESH_INTERVAL_HOURS`, default `24`. Re-asks SCANOSS for the vulnerabilities of components projects already have, between scans. Needs SCANOSS_API_KEY; 0 turns it off.
- `SCANOSS_FILE_CONTENT_API_KEY`, default empty.
- `SCANOSS_REMEDIATION_API_KEY`, default empty.
- `SCANOSS_REMEDIATION_API_URL`, default empty.
- `SCANS_POSTURE_RECONCILE_MINUTES`, default `30`. How often the projects index's stored posture metrics are recomputed for the whole estate, once per deployment: the safety net behind the recompute every change enqueues.

### Database migrations

8 new, applied in order by the `migrate` service on start.

**`0151_crypto_pqc_hybrid_history`**

```sql
ALTER TABLE public.posture_history
  ADD COLUMN crypto_pqc_hybrid INTEGER CHECK (crypto_pqc_hybrid >= 0);
```

**`0008_new_vulnerability_kind`**

```sql
ALTER TABLE notifications.notifications DROP CONSTRAINT notifications_kind_class;
ALTER TABLE notifications.notifications ADD CONSTRAINT notifications_kind_class CHECK (
    (kind IN ('kev_exposure', 'cra_deadline', 'new_vulnerability') AND class = 'security') OR
    (kind IN ('gate_failed', 'approval_requested', 'approval_decided') AND class = 'policy') OR
    (kind IN ('member_added', 'release_available') AND class = 'account')
);

ALTER TABLE notifications.notification_rules DROP CONSTRAINT notification_rules_kinds;
ALTER TABLE notifications.notification_rules ADD CONSTRAINT notification_rules_kinds CHECK (
    (class = 'security' AND kinds <@ ARRAY['kev_exposure', 'cra_deadline', 'new_vulnerability']) OR
    (class = 'policy'   AND kinds <@ ARRAY['gate_failed', 'approval_requested', 'approval_decided']) OR
    (class = 'account'  AND kinds <@ ARRAY['member_added', 'release_available'])
);

CREATE TABLE notifications.sweep_baselines (
    org_id       UUID        NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
    kind         TEXT        NOT NULL,
    baselined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (org_id, kind)
);
INSERT INTO notifications.sweep_baselines (org_id, kind, baselined_at)
SELECT org_id, 'kev_exposure', baselined_at FROM notifications.kev_sweep_baselines;
```

**`0078_vulnerability_refresh_state`**

```sql
CREATE TABLE scans.vulnerability_refresh_state (
    singleton    BOOLEAN     PRIMARY KEY DEFAULT TRUE CHECK (singleton),
    attempted_at TIMESTAMPTZ NOT NULL,
    succeeded_at TIMESTAMPTZ
);
```

**`0079_sbom_snapshot_catalogue_licences`**

```sql
UPDATE scans.sbom_component_snapshots snap
SET evidence = rewritten.evidence
FROM (
    SELECT
        s.scan_id,
        jsonb_agg(
            CASE
                WHEN jsonb_array_length(COALESCE(item.value -> 'license_ids', '[]'::jsonb)) = 0 THEN
                    jsonb_set(
                        item.value,
                        '{license_ids}',
                        to_jsonb(ARRAY(
                            SELECT DISTINCT l.spdx_id
                            FROM scans.components c
                            JOIN scans.component_licenses cl ON cl.component_id = c.id
                            JOIN scans.licenses l ON l.id = cl.license_id
                            WHERE c.purl = item.value ->> 'purl'
                              AND COALESCE(c.version, '') = COALESCE(item.value ->> 'version', '')
                              AND cl.first_seen_at <= s.captured_at
                              AND CASE cl.source
                                  WHEN 'sbom_concluded' THEN 1
                                  WHEN 'sbom_declared' THEN 2
                                  ELSE 0
                              END = 0
                            ORDER BY l.spdx_id
                        ))
                    )
                ELSE item.value
            END
            ORDER BY item.ordinality
        ) AS evidence
    FROM scans.sbom_component_snapshots s
    CROSS JOIN LATERAL jsonb_array_elements(s.evidence) WITH ORDINALITY AS item(value, ordinality)
    GROUP BY s.scan_id
) rewritten
WHERE snap.scan_id = rewritten.scan_id
  AND snap.evidence IS DISTINCT FROM rewritten.evidence;
```

**`0080_component_remediation`**

```sql
CREATE TABLE scans.component_remediation (
    component_id  UUID        PRIMARY KEY REFERENCES scans.components(id) ON DELETE CASCADE,
    outcome       TEXT        NOT NULL CHECK (outcome IN ('scored', 'component_not_found', 'version_not_found', 'invalid_purl', 'no_info')),
    assessment    JSONB,
    scored_at     TIMESTAMPTZ,
    kev_snapshot  DATE,
    epss_snapshot DATE,
    fetched_at    TIMESTAMPTZ NOT NULL,
    CHECK ((outcome = 'scored') = (assessment IS NOT NULL))
);
```

**`0081_project_posture_metrics`**

```sql
CREATE TABLE scans.project_posture_metrics (
    project_id                 UUID        PRIMARY KEY REFERENCES public.projects(id) ON DELETE CASCADE,
    scope_key                  TEXT        NOT NULL CHECK (scope_key <> ''),
    scanned                    BOOLEAN     NOT NULL,
    source_scan_id             UUID,
    last_scan_at               TIMESTAMPTZ,
    coverage                   TEXT        NOT NULL CHECK (coverage IN ('none', 'full', 'partial')),
    high_cves                  INTEGER     NOT NULL CHECK (high_cves >= 0),
    license_spdx_ids           TEXT[]      NOT NULL,
    components_missing_license INTEGER     NOT NULL CHECK (components_missing_license >= 0),
    computed_from              TIMESTAMPTZ NOT NULL,
    computed_at                TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK (scanned = (source_scan_id IS NOT NULL))
);
```

**`0082_dependencies_dep_purl_index`**

```sql
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_scans_dependencies_dep_purl
    ON scans.dependencies (dep_purl);
```

**`0002_statement_source`**

```sql
ALTER TABLE vulnerabilities.statements
    ADD COLUMN source          TEXT NOT NULL DEFAULT 'decision',
    ADD COLUMN source_document TEXT,
    ADD CONSTRAINT statements_source CHECK (source IN ('decision', 'vex_import')),
    ADD CONSTRAINT statements_source_document CHECK (
        (source = 'vex_import' AND source_document IS NOT NULL AND char_length(source_document) BETWEEN 1 AND 255)
        OR (source = 'decision' AND source_document IS NULL));

ALTER TABLE vulnerabilities.statement_revisions
    ADD COLUMN source          TEXT NOT NULL DEFAULT 'decision',
    ADD COLUMN source_document TEXT,
    ADD CONSTRAINT statement_revisions_source CHECK (source IN ('decision', 'vex_import')),
    ADD CONSTRAINT statement_revisions_source_document CHECK (
        (source = 'vex_import' AND source_document IS NOT NULL AND char_length(source_document) BETWEEN 1 AND 255)
        OR (source = 'decision' AND source_document IS NULL));
```

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

Dependency and Go toolchain bumps. Not marked as security fixes, though a bump can carry one.

- Bump crypto-finder to v0.54.0
- Bump crypto-finder to v0.53.0
- Bump crypto-finder to v0.50.1
- Tidy modules that depend on the bumped pgx and cli deps
- Hold jsdom majors back in dependabot
- Bump vite from 7.3.7 to 8.3.6 in /web
- Bump the web-minor-patch group in /web with 14 updates
- Bump @playwright/test in /web/e2e-real
- Bump github.com/jackc/pgx/v5
- Bump the go-minor-patch group

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

- Go 1.27.4 for GO-2026-6859
<!-- /earnie:stable-changes -->
