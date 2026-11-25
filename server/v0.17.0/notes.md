# Earnie v0.17.0

Released 2026-11-25.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.17.0`
- `ghcr.io/scanoss/earnie/earnie-web:v0.17.0`

<!-- earnie:stable-changes -->
## Changes since v0.16.0

For an admin moving from v0.16.0 to v0.17.0.

### Weekly releases included

- v0.17.0

### What's new

**Authentication**

- The CLI signs in with a code on a machine with no browser, and MCP sign-in is an organization setting

### Fixes

No user-facing changes.

### Upgrade steps

**Review before upgrading:**

- `tenant.env` keys were removed: delete them from your file if you set them.
- 2 database migration(s) run on start and `install.sh` does not reverse them: take the backup first, and roll back by restoring it.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.17.0`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

**Removed**

- `MCP_OAUTH_ENABLED` (was `false`)

### Database migrations

2 new, applied in order by the `migrate` service on start.

**`0167_oauth_device_authorization`**

```sql
SET LOCAL lock_timeout = '5s';

ALTER TABLE public.oauth_clients
    ADD COLUMN grant_types TEXT[] NOT NULL DEFAULT '{authorization_code,refresh_token}';
ALTER TABLE public.oauth_clients
    ADD CONSTRAINT oauth_clients_grant_types_check
    CHECK (cardinality(grant_types) >= 1
       AND grant_types <@ ARRAY['authorization_code', 'refresh_token', 'urn:ietf:params:oauth:grant-type:device_code']);

ALTER TABLE public.oauth_clients DROP CONSTRAINT oauth_clients_redirect_uris_check;
ALTER TABLE public.oauth_clients
    ADD CONSTRAINT oauth_clients_redirect_uris_check
    CHECK (cardinality(redirect_uris) <= 10
       AND (cardinality(redirect_uris) >= 1 OR NOT ('authorization_code' = ANY (grant_types))));

CREATE TABLE public.oauth_device_authorizations (
    device_code_hash  TEXT        PRIMARY KEY,
    user_code         TEXT        NOT NULL CHECK (user_code ~ '^[BCDFGHJKLMNPQRSTVWXZ]{8}$'),
    client_id         TEXT        NOT NULL REFERENCES public.oauth_clients (client_id) ON DELETE CASCADE,
    access            TEXT        NOT NULL CHECK (access IN ('mcp', 'api')),
    resource          TEXT        NOT NULL,
    scope             TEXT        NOT NULL,
    status            TEXT        NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'denied')),
    user_id           UUID        NULL REFERENCES public.users (id) ON DELETE CASCADE,
    organization_id   UUID        NULL REFERENCES public.organizations (id) ON DELETE CASCADE,
    interval_seconds  INTEGER     NOT NULL CHECK (interval_seconds BETWEEN 1 AND 600),
    requested_from    TEXT        NOT NULL DEFAULT '' CHECK (octet_length(requested_from) <= 64),
    created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    expires_at        TIMESTAMPTZ NOT NULL,
    last_polled_at    TIMESTAMPTZ NULL,
    decided_at        TIMESTAMPTZ NULL,
    consumed_at       TIMESTAMPTZ NULL,
    session_family_id UUID        NULL,
    CHECK ((status = 'pending') = (decided_at IS NULL)),
    CHECK (status = 'pending' OR user_id IS NOT NULL),
    CHECK (status <> 'approved' OR organization_id IS NOT NULL),
    CHECK (consumed_at IS NULL OR status = 'approved')
);

CREATE UNIQUE INDEX oauth_device_authorizations_pending_user_code
    ON public.oauth_device_authorizations (user_code)
    WHERE status = 'pending';
CREATE INDEX oauth_device_authorizations_expires_at
    ON public.oauth_device_authorizations (expires_at);
CREATE INDEX oauth_device_authorizations_client
    ON public.oauth_device_authorizations (client_id);
CREATE INDEX oauth_device_authorizations_user
    ON public.oauth_device_authorizations (user_id)
    WHERE user_id IS NOT NULL;
```

**`0168_mcp_sign_in_setting`**

```sql
SET LOCAL lock_timeout = '5s';

ALTER TABLE public.organizations
    ADD COLUMN mcp_sign_in_enabled    BOOLEAN     NOT NULL DEFAULT FALSE,
    ADD COLUMN mcp_sign_in_enabled_at TIMESTAMPTZ NULL,
    ADD COLUMN mcp_sign_in_updated_at TIMESTAMPTZ NULL,
    ADD COLUMN mcp_sign_in_updated_by UUID        NULL REFERENCES public.users (id);
```

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

No dependency or toolchain bump between v0.16.0 and v0.17.0.

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.16.0 and v0.17.0 is marked as a security fix.
<!-- /earnie:stable-changes -->

