# Earnie v0.16.0

Released 2026-11-25.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.16.0`
- `ghcr.io/scanoss/earnie/earnie-web:v0.16.0`

<!-- earnie:stable-changes -->
## Changes since v0.15.0

For an admin moving from v0.15.0 to v0.16.0.

### Weekly releases included

- v0.16.0

### What's new

**API**

- License sources, declaring manifests and vulnerability matched code

**Authentication**

- Developers sign in to MCP with the organization's SSO

**Command-line client**

- Earnie auth login --sso, REST accepts the CLI's sign-in, mcp setup without a key

**Findings**

- Analysis notes on a finding, from the API, MCP and the CLI

**SBOM export**

- The Files table is the last one in every report
- Files table in every snapshot report
- Freeze per-file match detail in the snapshot inventory
- The everything package makes every file of a scan as one ZIP

**Scans**

- Read a scan's dependency licences by the code-match rule

**Web interface**

- A finding's notes in its sheet, with a composer for writers
- Reports and Models stop repeating what another cell says
- Scan history says the shared gate and runner once
- DataTable folds a column every row agrees on into one line
- Secondary ink reads at APCA Lc 60 or more in both themes
- Download everything on a project's Reports opens the everything package
- Field hints read at 12px across the console
- A problem is one line on a card, and the header is the worst state
- Integrations as small provider cards, key rows and an imports table
- Add channel is a two-step dialog with a preview
- One type scale across the console; Settings fills the sheet
- Last sweep: Self-checks, SSO and Regulations say less
- The Not decided list drops the columns that say nothing
- Scan history and the audit log stop repeating themselves
- Report ledgers read quiet: who under when, formats as text
- A policy page says its rule once, as data
- A list parameter is one chip per value, the rest behind +N
- Policy lists read the rule as data
- Settings lists lead with the entity, chrome on hover
- The project dashboard opens on Needs attention
- Needs attention rows read as a dot and a sentence
- Projects opens on Needs attention and the projects
- The Projects status line reads counts, not shares
- Members carries the last sign-in under the email
- DataTable hideHeader for rows that explain themselves
- Members rows read as content first
- EntityCell and row controls that wait for the row
- Dashboards stop numbering their panels
- Widen the ink scale and add an icon tint
- Scan defaults nests its sections under its settings rail item at lg
- Settings navigation is a grouped rail beside a reading column
- Say where a license and a matched vulnerability come from
- Dashboards drop By policy, Evidence and per-panel CSV export
- Why it's here reads as labelled rows and opens the package in place
- The package panel names its facts and links its anchors
- Settings pages read at the tab strip's width
- Members drops the count line and the Roles section

**General**

- The package panel lists what a package brings in; the Tree tab goes

### Fixes

**SBOM export**

- Dependencies carry the licences their scan saw

**Scans**

- A rescan runs the default enrichments, not the prior scan's

**Web interface**

- Scan history folds the runner on identity, not display name
- Shared-scan line reads at one size, Models ignores the extension, org Reports e2e reads the folded creator
- The Excel report hint fits the copy budget
- A sheet opened on a package scrolls that package into view
- The empty repository note names Manage on GitHub, the card's button
- Drop the unmeasured time hints from the Add channel rows
- Enter in Add channel skips IME composition and a running save
- Fill pages cap at --content-max like every other page
- The Settings rail sits flush at every width; only the page column is capped
- Regenerate i18n scopes after rebasing on #2538's chip keys
- Parameters lists every value the rule card does not draw
- RuleParts is null for a rule of presence checks alone
- Read stack total labels by row index under Recharts 3.11
- EntityCell wraps free text at a measure
- Members drops a sort the Sort select does not offer
- Scan defaults no longer shifts its panels on load at lg
- The settings rail's groups, pages and sections read as three levels
- The SPDX picker's mode toggle stays on its input
- Name the statement history list
- Licenses' concluded-license list and license filter options

### Upgrade steps

**Review before upgrading:**

- 4 database migration(s) run on start and `install.sh` does not reverse them: take the backup first, and roll back by restoring it.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.16.0`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

**Added**

- `MCP_OAUTH_ENABLED`, default `false`. MCP sign-in through your SSO: a developer connects an MCP client such as Claude Code to https://${EARNIE_HOST}/mcp/v1 as themselves, with no API key, and every tool call is audited under their name. The client registers itself, the developer signs in through the console and allows it once. Off by default. On, EARNIE_PUBLIC_BASE_URL must be https. API keys keep working either way. See docs/deploy/mcp-sign-in.md.
- `MCP_OAUTH_SESSION_TTL`, default empty. How long one sign-in of an MCP client lasts before the developer signs in again: a duration from 1h to 2160h. Empty keeps 168h, 7 days.

### Database migrations

4 new, applied in order by the `migrate` service on start.

**`0163_finding_notes`**

```sql
CREATE TABLE public.finding_notes (
    id            BIGINT      GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    org_id        UUID        NOT NULL REFERENCES public.organizations(id),
    project_id    UUID        NOT NULL REFERENCES public.projects(id) ON DELETE RESTRICT,
    identity_hash TEXT        NOT NULL CHECK (identity_hash <> ''),
    finding_id    UUID        NOT NULL,
    body          TEXT        NOT NULL CHECK (body = btrim(body) AND char_length(body) BETWEEN 1 AND 4000),
    actor_kind    TEXT        NOT NULL CHECK (actor_kind IN ('user', 'api_key')),
    actor_id      UUID        NOT NULL,
    actor_display TEXT        NOT NULL DEFAULT '',
    request_id    UUID        NOT NULL,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT finding_notes_request UNIQUE (org_id, request_id)
);

CREATE INDEX finding_notes_latest
    ON public.finding_notes (project_id, identity_hash, id DESC);

CREATE FUNCTION public.finding_notes_append_only() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    RAISE EXCEPTION '% is append-only', TG_TABLE_NAME USING ERRCODE = 'integrity_constraint_violation';
END $$;

CREATE TRIGGER finding_notes_append_only
    BEFORE UPDATE OR DELETE ON public.finding_notes
    FOR EACH ROW EXECUTE FUNCTION public.finding_notes_append_only();
```

**`0164_mcp_oauth`**

```sql
CREATE TABLE public.oauth_clients (
    client_id     TEXT        PRIMARY KEY,
    client_name   TEXT        NOT NULL CHECK (octet_length(client_name) <= 100),
    redirect_uris TEXT[]      NOT NULL CHECK (cardinality(redirect_uris) BETWEEN 1 AND 10),
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    last_used_at  TIMESTAMPTZ NULL
);

CREATE INDEX oauth_clients_last_heard
    ON public.oauth_clients ((COALESCE(last_used_at, created_at)));

ALTER TABLE public.sessions ADD COLUMN client_id TEXT NULL;

ALTER TABLE public.sessions
    ADD CONSTRAINT sessions_client_id_fkey
    FOREIGN KEY (client_id) REFERENCES public.oauth_clients (client_id) ON DELETE CASCADE
    NOT VALID;

CREATE TABLE public.oauth_consents (
    user_id         UUID        NOT NULL REFERENCES public.users (id) ON DELETE CASCADE,
    client_id       TEXT        NOT NULL REFERENCES public.oauth_clients (client_id) ON DELETE CASCADE,
    redirect_target TEXT        NOT NULL CHECK (octet_length(redirect_target) BETWEEN 1 AND 2048),
    granted_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (user_id, client_id, redirect_target)
);

CREATE INDEX oauth_consents_client ON public.oauth_consents (client_id);
CREATE INDEX oauth_consents_granted_at ON public.oauth_consents (granted_at);

CREATE TABLE public.oauth_authorization_requests (
    id             UUID        PRIMARY KEY,
    user_id        UUID        NOT NULL REFERENCES public.users (id) ON DELETE CASCADE,
    client_id      TEXT        NOT NULL REFERENCES public.oauth_clients (client_id) ON DELETE CASCADE,
    redirect_uri   TEXT        NOT NULL,
    code_challenge TEXT        NOT NULL CHECK (length(code_challenge) = 43),
    state          TEXT        NOT NULL,
    resource       TEXT        NOT NULL,
    scope          TEXT        NOT NULL,
    created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    expires_at     TIMESTAMPTZ NOT NULL,
    decided_at     TIMESTAMPTZ NULL
);

CREATE INDEX oauth_authorization_requests_expires_at
    ON public.oauth_authorization_requests (expires_at);
CREATE INDEX oauth_authorization_requests_client
    ON public.oauth_authorization_requests (client_id);

CREATE TABLE public.oauth_authorization_codes (
    code_hash         TEXT        PRIMARY KEY,
    user_id           UUID        NOT NULL REFERENCES public.users (id) ON DELETE CASCADE,
    organization_id   UUID        NOT NULL REFERENCES public.organizations (id) ON DELETE CASCADE,
    client_id         TEXT        NOT NULL REFERENCES public.oauth_clients (client_id) ON DELETE CASCADE,
    redirect_uri      TEXT        NOT NULL,
    code_challenge    TEXT        NOT NULL CHECK (length(code_challenge) = 43),
    resource          TEXT        NOT NULL,
    expires_at        TIMESTAMPTZ NOT NULL,
    consumed_at       TIMESTAMPTZ NULL,
    session_family_id UUID        NULL
);

CREATE INDEX oauth_authorization_codes_expires_at
    ON public.oauth_authorization_codes (expires_at);
CREATE INDEX oauth_authorization_codes_client
    ON public.oauth_authorization_codes (client_id);
```

**`0165_sessions_client_index`**

```sql
CREATE INDEX CONCURRENTLY IF NOT EXISTS sessions_client
    ON public.sessions (client_id)
    WHERE client_id IS NOT NULL;
```

**`0166_oauth_access_kind`**

```sql
SET LOCAL lock_timeout = '5s';

ALTER TABLE public.oauth_authorization_requests
    ADD COLUMN access TEXT NOT NULL DEFAULT 'mcp' CHECK (access IN ('mcp', 'api'));
ALTER TABLE public.oauth_authorization_codes
    ADD COLUMN access TEXT NOT NULL DEFAULT 'mcp' CHECK (access IN ('mcp', 'api'));

ALTER TABLE public.sessions ADD COLUMN client_access TEXT NULL;
ALTER TABLE public.sessions
    ADD CONSTRAINT sessions_client_access_check
    CHECK (client_access IS NULL OR (client_id IS NOT NULL AND client_access IN ('mcp', 'api')))
    NOT VALID;

ALTER TABLE public.oauth_consents ADD COLUMN api_granted_at TIMESTAMPTZ NULL;
```

### Outbound network destinations

New or changed `tenant.env` keys that name a destination:

- `MCP_OAUTH_ENABLED`: `https://${EARNIE_HOST}/mcp/v1`. MCP sign-in through your SSO: a developer connects an MCP client such as Claude Code to https://${EARNIE_HOST}/mcp/v1 as themselves, with no API key, and every tool call is audited under their name. The client registers itself, the developer signs in through the console and allows it once. Off by default. On, EARNIE_PUBLIC_BASE_URL must be https. API keys keep working either way. See docs/deploy/mcp-sign-in.md.

### Dependency and toolchain updates

Dependency and Go toolchain bumps. Not marked as security fixes, though a bump can carry one.

- Tidy earnie-api and earnie for the otel and CLI dependency updates
- Bump @xyflow/react from 12.12.1 to 13.0.2 in /web
- Bump the web-minor-patch group in /web with 10 updates
- Bump the go-minor-patch group
- Bump @playwright/test in /web/e2e-real
- Bump golang.org/x/tools
- Bump golang
- Bump go.opentelemetry.io/otel/trace in /platform
- Bump go.opentelemetry.io/otel/trace in /cmd/earnie-admin

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.15.0 and v0.16.0 is marked as a security fix.
<!-- /earnie:stable-changes -->

