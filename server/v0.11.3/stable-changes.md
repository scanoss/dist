## Changes since v0.4.12

For an admin moving from v0.4.12 to v0.11.3.

### Weekly releases included

- v0.5.0
- v0.6.0
- v0.7.0
- v0.8.0
- v0.9.0
- v0.10.0
- v0.11.0
- v0.11.1
- v0.11.2
- v0.11.3

### What's new

**Breaking changes**

- SBOM export: A report is an export preset with a template, sections and the logo

**Audit**

- A governance activity read, also on MCP posture

**Authentication**

- An organization default dashboard layout an Admin saves
- GET /v1/organization/scan-configuration/projects, every project's scan settings in one read

**Cli,mcp**

- Earnie export and MCP make any preset, report or package, and list exports

**Command-line client**

- Add earnie check to check files and folders once
- Earnie vulnerabilities list and decide

**Integrations**

- Report a GitLab merge request result as an external status check
- Log the plain http SCM hosts an operator allowed at start-up
- Let an operator allow plain http GitLab and GitHub Enterprise Server hosts

**MCP and agents**

- Coding agents attach and detach a policy on a project
- Earnie_try_policy lets a coding agent try a policy draft on a project

**Policies**

- Posture history records unclassified and weak copyleft licenses
- The shipped CVE policies skip what the project stated not affected or fixed
- One list of policy approvals across the organization's projects
- Detach a policy from one project, and the org list says where each policy applies
- Vulnerability.vex_status reads the project's VEX statement
- POST /v1/projects/{projectId}/policies:try runs a draft over a project's findings
- GET /v1/policies/{id}/changes and last_change on a policy
- Policy.updated records each changed field with its value before and after
- Filter a project's policies to those with pending approvals
- Decide a Policy Approval in a drawer that shows the request

**Policies,scans**

- Per-policy outcomes and dated evidence, also on MCP posture

**Reports**

- One organization Reports page and one bulk New export across projects

**SBOM export**

- An OpenVEX export of the project's vulnerability statements
- A CycloneDX VEX file of the project's statements, for scanners like Trivy
- CycloneDX exports carry each CVE's VEX statement as analysis
- Summary charts in Executive and Compliance reports
- Compliance packages freeze a scan once and hand over every file a regulation asks for

**Scans**

- Return what a Self-check found
- Let a failed scan's check stay advisory
- The PR summary says how many new vulnerabilities have no VEX statement
- Project CVE counts leave out CVEs stated not affected or fixed

**Tools**

- Push once per round of fixes, and never while the PR's CI is still running

**Triage**

- Decision throughput reads a project set
- Not a match decision for OSS code matches

**Verify**

- Check performance on every web change, with budgets that fail a regression
- Run a fake SCANOSS API with the verify stack so OSS scans complete
- Page budgets and a phone-width check for every page driven
- One stack per checkout, so worktrees verify side by side

**Vulnerabilities**

- The Vulnerabilities page opens with severity by decision
- Say why a vulnerability is in the project

**Web interface**

- Noto Sans and navy ink from earnie.dev, Newsreader kept for titles
- List what a Self-check found on its run page
- Box settings rows and put each control on the right edge
- Raise structural contrast in both themes
- Show when a GitLab or GitHub connection uses plain http
- Page-level empty states show the Earnie owl on a dot field
- Settings and scan-configuration rows read as a spec sheet
- Dashboards read as one ruled report grid, and the organisation status line takes the verdict shape
- Gate over time draws stacked bars of projects by gate, per day
- Review's filter row is a query bar, with its facet picker as the menu
- Organization and settings lists filter with the query-token bar
- Scan history and Self-checks filter with the query-token bar
- The Inventory lists filter with the query-token bar
- Query-token filter bar, first on the Policies list
- Verdict gutter on the Policies, Scan history and Self-checks lists
- Page header with a verdict line, provenance and a description popover
- Design system refresh, slice 2: labels and status
- Design system refresh, slice 1: tokens
- By policy, Top policies and Evidence on the dashboards
- Named sidebar groups, one content width, settings actions on the tab row
- License exposure on both dashboards, and an organization default layout
- Pull requests and Agents on both dashboards, Decisions on the organization one
- The organization dashboard is one page under a status line
- The policies page gathers every project's approvals, and the separation of duties rule moves there from Settings
- An organization policy library at /policies, with attach and detach per project
- Dashboard charts in the Analytics style
- Algorithms charts post-quantum status and severity above its table, each legend item a filter
- Earnie speaks Japanese, Chinese, French, German and Korean
- The project dashboard header is one block, sections lead with a chart, and edit mode adds panels per section
- The project dashboard is one page of three sections
- Try it runs a policy draft on a project before saving, and readiness moves to the save bar
- Dashboard panels drag on touch, size to four presets, and save on Save layout
- Settings lists keep their view in the URL
- Review CVE chips say what the project's VEX states
- A Go to palette, Cmd+K on a Mac or Ctrl+K, over every page and project
- Models on the inventory template, decisions move to Review
- Scan detail as one page with a real stage list
- The Policies list says who changed each policy last
- The audit log is an organization page at /audit-log, out of Settings
- A policy's page says who changed it last and lists every change
- Scan history as a run log with its state in the URL
- Algorithms on the inventory template
- The top bar says where you are, organization / project
- Each level's rail lists only its own pages, ordered read, configure, Review
- Inventory template pieces, adopted by Dependencies
- One registry of rail pages, and a project switch keeps every page
- The project's Vulnerabilities page records VEX statements
- A part of the policy rule shown as CEL says why and keeps its parameters editable
- Every policy parameter is a chip in a numbered sentence
- The organization's Scan configuration lists every project and which ones differ
- One Reports page lists every export, and /sboms redirects to it
- The policy editor reads top to bottom as the policy itself
- The policy editor saves from a bar that says what the save reaches
- Pre-commit says how to install the hook; Pull-request feedback in groups
- New export sheet with six presets replaces Generate snapshot
- Inherited Scan configuration beside the project's own values
- Shared export pieces: one vocabulary, download helper, Export menu, format chips
- A page whose width carries data widens to 1920px
- The New policy picker in three panes
- Scan configuration on one page, in the order Earnie acts
- Each Policies list row reads its rule in plain words
- The approvals queue switches status with a count on each
- Tabs and filters keep their state in the URL
- One label each for the require action and its waiting state

**General**

- A provenance footer closes Members and Policies, with the organisation's last sign-in from the API
- One Cryptography page, and a crypto finding's route you can check hop by hop
- Resolve likely snippet non-matches when an org or project opts in (preview, off)
- Inventory summaries are panels that fill the page, and Dependencies charts license category with a License category filter
- Models charts identification and license category above its table, with a License filter
- Algorithms and Models name their scan and repeated candidates from the API
- Dependencies gets license and open findings from the packages call
- Self-checks as a run list with per-status counts

### Fixes

**Build**

- Upgrade libbrotli1 and openjdk-21 in the api image for two fixed CRITICALs

**Command-line client**

- Scan staged reports its own timeout, not the pre-commit hook's
- Keep the PolicyViolationSeverity constant names in earnieclient

**Database**

- Renumber the license posture migration to 0147

**Gitlab**

- Publish a neutral check as a passing commit status, not skipped

**Integrations**

- GitLab account move follow-ups (#1934, #1933, #1932)

**MCP and agents**

- Earnie_list_exports kind filters by what an export is, not the files it carries

**Policies**

- Give policies finding.match_percent from oss-diff evidence
- A triage decision and its revert re-evaluate the project's policies
- An evaluation that waits for the project lock no longer stores a stale read over the newer result
- A re-evaluation that returns to earlier inputs moves the current result back

**Projects**

- Strict POST /v1/projects, and an empty description clears it

**Queue**

- Hand in-flight scans to another replica on shutdown instead of failing them

**SBOM export**

- Send the API key only to the configured SCANOSS host on notice fetches

**Scans**

- Mark a dependency dev when its manifest declares it for development
- CLI and browser folder uploads work across several api replicas
- Skip a manifest that fails to parse instead of dropping every dependency
- Honor on_failure_only on GitLab merge requests
- Install Node and Python dependencies in the crypto sandbox
- Keep crypto coverage full when an occurrence is duplicated
- Sweep crypto findings of every dependency the run observed completely
- A dependency cut short by a limit is not complete crypto evidence
- Resolve a licence's copyleft flag from its current SPDX id and the taxonomy
- Show a crypto finding's strongest route first, not its shortest
- Rescan when the effective scan configuration changes
- Keep the scan when an unkeyed commit-ingest is retried
- Idle sweep reclaims receiving uploads without a live progress row
- Notice_missing needs an SBOM, so the evidence counts agree
- Self-check submit carries its Project; correct the run-count doc
- A default Self-check skips a queued scanner no worker serves

**Web interface**

- The shell renders on the server again under Node 20
- Chart dates fit a phone's width, and the chart neutrals go cool
- Show the file when a crypto finding's detail fails to load
- Open a dependency crypto finding's proof instead of its library file
- Draw the owl logo and favicons in the console's ink, not navy
- Audit log event labels read as product copy, guarded against the backend's event types
- The Projects table stays inside its dashboard card
- Finish setup rows link to the default project on org-level routes
- Login returnTo, Violations badge total, Self-check phone overflow
- Skip setup navigates only after the profile says onboarded (e2e governed-project flake)
- The Integrations attention list is a page section, not a card
- The CEL view reads in dark mode, says syntax errors in words and marks where they are
- Only the page's scrolling moves the Scan configuration rail
- The user guide's mock API serves the shipped template catalog

**General**

- Every live post-merge QA issue, and QA runs on the CI seat again

### Upgrade steps

**Review before upgrading:**

- 18 database migration(s) run on start and `install.sh` does not reverse them: take the backup first, and roll back by restoring it.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.11.3`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

**Added**

- `EARNIE_SCM_INSECURE_HTTP_HOSTS`, default empty. GitLab and GitHub Enterprise Server hosts reached over plain http instead of https: comma-separated host or host:port, such as gitlab.intra,ghes.corp:8080. Empty, the default, allows none. On a listed host the token and the code travel in clear text, so list one only on a network you control. Hosts not listed stay https only.
- `EARNIE_SHUTDOWN_DRAIN_SECONDS`, default empty. Seconds a stopping process gives in-flight scan jobs and the event bus to finish, after up to 30 seconds closing HTTP connections. Empty means 60; any value but a whole number of seconds stops the server at boot. The process cannot see how long its container gets to stop, so 30 + this + a margin must stay below that: compose waits 120 seconds (stop_grace_period), so keep the default here; elsewhere, raise the stop grace together with this value.

### Database migrations

18 new, applied in order by the `migrate` service on start.

**`0140_vulnerabilities_permissions`**

```sql
UPDATE roles
SET permissions = array_append(permissions, 'vulnerabilities:decide')
WHERE name IN ('admin', 'operator')
  AND is_system = TRUE
  AND NOT ('vulnerabilities:decide' = ANY(permissions));
```

**`0141_applicable_regulations`**

```sql
ALTER TABLE public.organizations
  ADD COLUMN IF NOT EXISTS applicable_regulations TEXT[] NOT NULL DEFAULT '{}';
```

**`0142_estate_export_options`**

```sql
ALTER TABLE public.estate_action_runs
  ADD COLUMN export_options JSONB;
```

**`0143_estate_item_snapshot`**

```sql
ALTER TABLE public.estate_action_items
  ADD COLUMN snapshot_id UUID;
```

**`0144_policy_current_result_trigger`**

```sql
ALTER TABLE public.policy_current_results
  ADD COLUMN evaluation_trigger TEXT;

UPDATE public.policy_current_results result
SET evaluation_trigger = evaluation.trigger
FROM public.policy_evaluations evaluation
WHERE evaluation.id = result.evaluation_id;

ALTER TABLE public.policy_current_results
  ALTER COLUMN evaluation_trigger SET NOT NULL,
  ADD CONSTRAINT policy_current_results_evaluation_trigger_check
    CHECK (evaluation_trigger IN ('scan', 'policy_change', 'manual'));
```

**`0145_user_locale`**

```sql
ALTER TABLE users ADD COLUMN locale text NULL
    CONSTRAINT users_locale_supported CHECK (locale IN ('en', 'ja', 'zh-CN', 'fr', 'de', 'ko'));
```

**`0146_scan_configuration_snippet_auto_resolve`**

```sql
ALTER TABLE public.org_scan_configurations
  ADD COLUMN snippet_auto_resolve JSONB NOT NULL DEFAULT '{}'::jsonb;

ALTER TABLE public.project_scan_configurations
  ADD COLUMN snippet_auto_resolve JSONB NOT NULL DEFAULT '{}'::jsonb;
```

**`0147_license_posture_history`**

```sql
ALTER TABLE public.posture_history
  ADD COLUMN licenses_unclassified   INTEGER CHECK (licenses_unclassified >= 0),
  ADD COLUMN licenses_weak_copyleft  INTEGER CHECK (licenses_weak_copyleft >= 0);
```

**`0148_organization_dashboard_layouts`**

```sql
CREATE TABLE public.organization_dashboard_layouts (
  organization_id UUID        NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  scope           TEXT        NOT NULL CHECK (scope <> '' AND length(scope) <= 64),
  signature       TEXT        NOT NULL CHECK (length(signature) <= 512),
  cards           JSONB       NOT NULL,
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_by      UUID        REFERENCES public.users(id) ON DELETE SET NULL,
  PRIMARY KEY (organization_id, scope)
);
```

**`0149_pr_scan_failure_check`**

```sql
ALTER TABLE public.project_pr_feedback_settings
  ADD COLUMN scan_failure_check TEXT NOT NULL DEFAULT 'block'
    CHECK (scan_failure_check IN ('block', 'advisory'));

ALTER TABLE public.org_pr_feedback_settings
  ADD COLUMN scan_failure_check TEXT NOT NULL DEFAULT 'block'
    CHECK (scan_failure_check IN ('block', 'advisory'));
```

**`0150_pr_check_placement`**

```sql
ALTER TABLE public.project_pr_feedback_settings
  ADD COLUMN check_placement TEXT NOT NULL DEFAULT 'commit_status'
    CHECK (check_placement IN ('commit_status', 'status_check', 'both'));

ALTER TABLE public.org_pr_feedback_settings
  ADD COLUMN check_placement TEXT NOT NULL DEFAULT 'commit_status'
    CHECK (check_placement IN ('commit_status', 'status_check', 'both'));
```

**`0012_report_variants`**

```sql
CREATE TABLE sbom.snapshot_report_variants (
    id                  UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    snapshot_id         UUID        NOT NULL REFERENCES sbom.snapshots(id) ON DELETE CASCADE,
    format              TEXT        NOT NULL,
    variant             TEXT        NOT NULL,
    report_template     TEXT        NOT NULL,
    report_sections     TEXT[]      NOT NULL,
    artifact_ref        TEXT        NOT NULL,
    artifact_sha256     TEXT        NOT NULL,
    artifact_size_bytes BIGINT      NOT NULL,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (snapshot_id, format, variant)
);

CREATE INDEX snapshot_report_variant_object ON sbom.snapshot_report_variants (artifact_ref);

CREATE FUNCTION sbom.journal_deleted_snapshot_report_variants()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO sbom.artifact_cleanup (artifact_key)
    SELECT artifact_ref FROM deleted_variants WHERE artifact_ref <> ''
    ON CONFLICT (artifact_key) DO NOTHING;
    RETURN NULL;
END;
$$;

CREATE TRIGGER trg_snapshot_report_variants_journal_deleted
AFTER DELETE ON sbom.snapshot_report_variants
REFERENCING OLD TABLE AS deleted_variants
FOR EACH STATEMENT EXECUTE FUNCTION sbom.journal_deleted_snapshot_report_variants();

ALTER TABLE sbom.snapshots
    ADD COLUMN generated_by_display TEXT    NOT NULL DEFAULT '',
    ADD COLUMN preset               TEXT    NULL,
    ADD COLUMN crypto_asset_count   INTEGER NULL;
```

**`0013_snapshot_package`**

```sql
ALTER TABLE sbom.snapshots
    ADD COLUMN package       TEXT  NULL,
    ADD COLUMN omitted_parts JSONB NULL;
```

**`0014_snapshot_org_listing_index`**

```sql
CREATE INDEX CONCURRENTLY IF NOT EXISTS snapshots_org_generated
    ON sbom.snapshots (org_id, generated_at DESC, id DESC);
```

**`0075_component_vulnerability_aliases`**

```sql
ALTER TABLE scans.component_vulnerabilities
  ADD COLUMN aliases TEXT[] NOT NULL DEFAULT '{}';
```

**`0076_license_obligations_reresolve`**

```sql
UPDATE scans.licenses SET obligations_resolved_at = NULL;
```

**`0077_scan_ingest_received_files`**

```sql
CREATE TABLE scans.scan_ingest_received_files (
    scan_id    UUID   NOT NULL REFERENCES scans.scans(id) ON DELETE CASCADE,
    path       TEXT   NOT NULL,
    sha256     TEXT   NOT NULL,
    size_bytes BIGINT NOT NULL,

    PRIMARY KEY (scan_id, path),
    CONSTRAINT chk_scan_ingest_received_sha256 CHECK (sha256 ~ '^[0-9a-f]{64}$'),
    CONSTRAINT chk_scan_ingest_received_size CHECK (size_bytes >= 0)
);
```

**`0001_vulnerabilities_schema`**

```sql
CREATE SCHEMA IF NOT EXISTS vulnerabilities;

CREATE TABLE vulnerabilities.statements (
    id               UUID        PRIMARY KEY,
    org_id           UUID        NOT NULL REFERENCES public.organizations(id),
    project_id       UUID        NOT NULL REFERENCES public.projects(id) ON DELETE RESTRICT,
    purl             TEXT        NOT NULL,
    version          TEXT        NOT NULL DEFAULT '',
    cve_id           TEXT        NOT NULL,
    revision         INT         NOT NULL CHECK (revision >= 1),
    status           TEXT        CHECK (status IN ('not_affected', 'affected', 'fixed', 'under_investigation')),
    justification    TEXT        CHECK (justification IN ('component_not_present', 'vulnerable_code_not_present',
                                        'vulnerable_code_not_in_execute_path',
                                        'vulnerable_code_cannot_be_controlled_by_adversary',
                                        'inline_mitigations_already_exist')),
    impact_statement TEXT,
    action_statement TEXT,
    author_kind      TEXT        NOT NULL CHECK (author_kind IN ('user', 'api_key')),
    author_id        UUID        NOT NULL,
    author_name      TEXT,
    origin           TEXT        NOT NULL CHECK (origin IN ('person', 'agent')),
    first_issued_at  TIMESTAMPTZ NOT NULL,
    last_updated_at  TIMESTAMPTZ NOT NULL,
    CONSTRAINT statements_identity UNIQUE (org_id, project_id, purl, version, cve_id),
    CONSTRAINT statements_status_fields CHECK (COALESCE(
        (status IS NULL AND justification IS NULL AND impact_statement IS NULL AND action_statement IS NULL)
        OR (status = 'not_affected' AND justification IS NOT NULL AND action_statement IS NULL)
        OR (status = 'affected' AND action_statement IS NOT NULL AND justification IS NULL AND impact_statement IS NULL)
        OR (status IN ('fixed', 'under_investigation')
            AND justification IS NULL AND impact_statement IS NULL AND action_statement IS NULL),
        false))
);

CREATE INDEX statements_org_project ON vulnerabilities.statements (org_id, project_id);

CREATE FUNCTION vulnerabilities.statements_guard() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.org_id <> OLD.org_id OR NEW.project_id <> OLD.project_id OR NEW.purl <> OLD.purl
       OR NEW.version <> OLD.version OR NEW.cve_id <> OLD.cve_id OR NEW.first_issued_at <> OLD.first_issued_at THEN
        RAISE EXCEPTION 'vulnerabilities.statements identity and first_issued_at are immutable'
            USING ERRCODE = 'integrity_constraint_violation';
    END IF;
    RETURN NEW;
END $$;

CREATE TRIGGER statements_guard BEFORE UPDATE ON vulnerabilities.statements
    FOR EACH ROW EXECUTE FUNCTION vulnerabilities.statements_guard();

CREATE TABLE vulnerabilities.statement_revisions (
    statement_id     UUID        NOT NULL REFERENCES vulnerabilities.statements(id),
    revision         INT         NOT NULL CHECK (revision >= 1),
    action           TEXT        NOT NULL CHECK (action IN ('record', 'withdraw')),
    status           TEXT        CHECK (status IN ('not_affected', 'affected', 'fixed', 'under_investigation')),
    justification    TEXT        CHECK (justification IN ('component_not_present', 'vulnerable_code_not_present',
                                        'vulnerable_code_not_in_execute_path',
                                        'vulnerable_code_cannot_be_controlled_by_adversary',
                                        'inline_mitigations_already_exist')),
    impact_statement TEXT,
    action_statement TEXT,
    recorded_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    author_kind      TEXT        NOT NULL CHECK (author_kind IN ('user', 'api_key')),
    author_id        UUID        NOT NULL,
    author_name      TEXT,
    origin           TEXT        NOT NULL CHECK (origin IN ('person', 'agent')),
    request_id       UUID        NOT NULL,
    PRIMARY KEY (statement_id, revision),
    CONSTRAINT statement_revisions_withdraw_iff_no_status CHECK ((action = 'withdraw') = (status IS NULL)),
    CONSTRAINT statement_revisions_status_fields CHECK (COALESCE(
        (status IS NULL AND justification IS NULL AND impact_statement IS NULL AND action_statement IS NULL)
        OR (status = 'not_affected' AND justification IS NOT NULL AND action_statement IS NULL)
        OR (status = 'affected' AND action_statement IS NOT NULL AND justification IS NULL AND impact_statement IS NULL)
        OR (status IN ('fixed', 'under_investigation')
            AND justification IS NULL AND impact_statement IS NULL AND action_statement IS NULL),
        false))
);

CREATE FUNCTION vulnerabilities.append_only() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    RAISE EXCEPTION '% is append-only', TG_TABLE_NAME USING ERRCODE = 'integrity_constraint_violation';
END $$;

CREATE TRIGGER statement_revisions_append_only BEFORE UPDATE OR DELETE ON vulnerabilities.statement_revisions
    FOR EACH ROW EXECUTE FUNCTION vulnerabilities.append_only();

CREATE TABLE vulnerabilities.decisions (
    org_id      UUID        NOT NULL REFERENCES public.organizations(id),
    request_id  UUID        NOT NULL,
    project_id  UUID        NOT NULL,
    fingerprint TEXT        NOT NULL,
    applied_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (org_id, request_id)
);

CREATE TRIGGER decisions_append_only BEFORE UPDATE OR DELETE ON vulnerabilities.decisions
    FOR EACH ROW EXECUTE FUNCTION vulnerabilities.append_only();
```

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

Dependency and Go toolchain bumps. Not marked as security fixes, though a bump can carry one.

- Bump crypto-finder to v0.46.5
- Bump crypto-finder to v0.46.4
- Bump crypto-finder to v0.46.1
- Sweep Dependabot's golang digest, bubbletea and web minor bumps
- Clear the open Dependabot alerts (Go, web tooling, ai-finder lock)
- Sweep dependabot web, e2e, alpine and oapi-codegen runtime bumps
- The Go suite skips what no Go build or test reads

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.4.12 and v0.11.3 is marked as a security fix.
