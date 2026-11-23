# Earnie v0.15.0

Released 2026-11-23.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.15.0`
- `ghcr.io/scanoss/earnie/earnie-web:v0.15.0`

<!-- earnie:stable-changes -->
## Changes since v0.14.0

For an admin moving from v0.14.0 to v0.15.0.

### Weekly releases included

- v0.15.0

### What's new

**API**

- CI OIDC token exchange contract

**Audit**

- Stream the audit log to a SIEM over a signed webhook

**Authentication**

- CI OIDC token exchange for GitHub Actions and GitLab
- Service accounts, organization-owned identities for pipelines

**Command-line client**

- Earnie auth login --oidc

**Integrations**

- Register an existing GitHub App from an Admin session

**Web interface**

- CI token exchange setting and trust rules
- Run the audit log stream from notification settings

### Fixes

**Authentication**

- A replayed token's 409 no longer tells a signed-in job to fetch a new token
- Count an IPv6 /64 as one client of the token exchange
- A refetch of issuer keys no longer stalls other exchanges
- Refuse a control character in a trust rule's name
- Refuse a trust rule with an unknown condition key
- Refuse control characters in a CI token's iss, jti and claims

**Command-line client**

- Auth login --oidc tells a signed-in job it needs no second sign-in

**Database**

- Build the exchanged-key sweep index CONCURRENTLY in 0162

**Netguard**

- Block GCP's IPv6 metadata address even with AllowPrivate

**Verify**

- Drive-api-key-mcp expects 'Never' and the seed's 7 policies

**Web interface**

- A trust rule's mark and actions sit on the name's first line
- A trust rule's mark, name and actions share one centre line
- A code block without line numbers drops its empty gutter
- Trust rules read as rows with the provider's mark, and the CI snippet is highlighted
- The CI token exchange setting sits on its section's panel, not in a second box
- Trust rules stack as cards in the account sheet

### Upgrade steps

**Review before upgrading:**

- 5 database migration(s) run on start and `install.sh` does not reverse them: take the backup first, and roll back by restoring it.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.15.0`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

**Added**

- `EARNIE_CI_OIDC_ALLOW_PRIVATE_ISSUERS`, default `false`. CI token exchange (Settings > Service accounts) fetches the signing keys of the issuer a trust rule names: GitHub Actions, gitlab.com or your GitLab. Set to true only when that GitLab is on a private address (RFC 1918, loopback): the keys may then be fetched from one, and a rule may name a plain-http issuer on a loopback host, for testing. Off by default, so keys are fetched from public addresses over https only. Cloud metadata addresses stay blocked either way.

### Database migrations

5 new, applied in order by the `migrate` service on start.

**`0158_audit_stream`**

```sql
CREATE SEQUENCE public.audit_log_stream_seq AS BIGINT;

ALTER TABLE public.audit_log_entries
    ADD COLUMN stream_xid BIGINT,
    ADD COLUMN stream_seq BIGINT;

ALTER TABLE public.audit_log_entries
    ALTER COLUMN stream_xid SET DEFAULT (pg_current_xact_id()::text::bigint),
    ALTER COLUMN stream_seq SET DEFAULT nextval('public.audit_log_stream_seq');

CREATE TABLE public.audit_stream_settings (
    org_id               UUID        PRIMARY KEY REFERENCES public.organizations(id) ON DELETE RESTRICT,
    channel_id           UUID        NOT NULL,
    enabled              BOOLEAN     NOT NULL DEFAULT TRUE,
    cursor_xid           BIGINT      NOT NULL,
    cursor_seq           BIGINT      NOT NULL,
    last_event_id        UUID,
    last_delivered_at    TIMESTAMPTZ,
    delivered_total      BIGINT      NOT NULL DEFAULT 0,
    last_error           TEXT,
    last_error_at        TIMESTAMPTZ,
    consecutive_failures INT         NOT NULL DEFAULT 0,
    next_attempt_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    lease_id             UUID,
    lease_until          TIMESTAMPTZ,
    created_at           TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

**`0159_audit_stream_cursor_index`**

```sql
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_audit_log_stream_position
    ON public.audit_log_entries (org_id, stream_xid, stream_seq)
    WHERE stream_xid IS NOT NULL;
```

**`0160_service_accounts`**

```sql
CREATE TABLE public.service_accounts (
    id              UUID        PRIMARY KEY,
    organization_id UUID        NOT NULL REFERENCES public.organizations (id),
    name            TEXT        NOT NULL,
    description     TEXT        NOT NULL DEFAULT '',
    scopes          TEXT[]      NOT NULL,
    project_ids     UUID[]      NOT NULL DEFAULT '{}',
    created_by      UUID        NOT NULL REFERENCES public.users (id),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    disabled_at     TIMESTAMPTZ NULL,
    disabled_by     UUID        NULL REFERENCES public.users (id)
);

CREATE UNIQUE INDEX service_accounts_org_active_name
    ON public.service_accounts (organization_id, lower(name))
    WHERE disabled_at IS NULL;

ALTER TABLE public.api_keys
    ADD COLUMN service_account_id UUID NULL REFERENCES public.service_accounts (id);

UPDATE roles
SET permissions = array_append(permissions, 'serviceaccounts:read')
WHERE name = 'admin'
  AND is_system = TRUE
  AND NOT ('serviceaccounts:read' = ANY(permissions));

UPDATE roles
SET permissions = array_append(permissions, 'serviceaccounts:write')
WHERE name = 'admin'
  AND is_system = TRUE
  AND NOT ('serviceaccounts:write' = ANY(permissions));
```

**`0161_ci_oidc_token_exchange`**

```sql
CREATE TABLE public.ci_trust_rules (
    id                 UUID        PRIMARY KEY,
    organization_id    UUID        NOT NULL REFERENCES public.organizations (id),
    service_account_id UUID        NOT NULL REFERENCES public.service_accounts (id),
    name               TEXT        NOT NULL,
    provider           TEXT        NOT NULL CHECK (provider IN ('github_actions', 'gitlab')),
    issuer             TEXT        NOT NULL,
    audience           TEXT        NOT NULL,
    conditions         JSONB       NOT NULL,
    token_ttl_minutes  INT         NOT NULL CHECK (token_ttl_minutes BETWEEN 1 AND 60),
    created_by         UUID        NOT NULL REFERENCES public.users (id),
    created_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at         TIMESTAMPTZ NULL,
    deleted_by         UUID        NULL REFERENCES public.users (id),
    last_exchanged_at  TIMESTAMPTZ NULL
);

CREATE INDEX ci_trust_rules_org_issuer
    ON public.ci_trust_rules (organization_id, issuer)
    WHERE deleted_at IS NULL;

CREATE INDEX ci_trust_rules_service_account
    ON public.ci_trust_rules (service_account_id);

CREATE TABLE public.ci_token_exchanges (
    issuer     TEXT        NOT NULL,
    jti        TEXT        NOT NULL,
    expires_at TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (issuer, jti)
);

CREATE INDEX ci_token_exchanges_expires_at
    ON public.ci_token_exchanges (expires_at);

ALTER TABLE public.api_keys
    ADD COLUMN trust_rule_id UUID NULL REFERENCES public.ci_trust_rules (id);


ALTER TABLE public.organizations
    ADD COLUMN ci_token_exchange_enabled    BOOLEAN     NOT NULL DEFAULT FALSE,
    ADD COLUMN ci_token_exchange_updated_at TIMESTAMPTZ NULL,
    ADD COLUMN ci_token_exchange_updated_by UUID        NULL REFERENCES public.users (id);
```

**`0162_api_keys_exchanged_expiry_index`**

```sql
CREATE INDEX CONCURRENTLY IF NOT EXISTS api_keys_exchanged_expiry
    ON public.api_keys (expires_at, id)
    WHERE trust_rule_id IS NOT NULL;
```

### Outbound network destinations

New or changed `tenant.env` keys that name a destination:

- `EARNIE_CI_OIDC_ALLOW_PRIVATE_ISSUERS`: `gitlab.com`. CI token exchange (Settings > Service accounts) fetches the signing keys of the issuer a trust rule names: GitHub Actions, gitlab.com or your GitLab. Set to true only when that GitLab is on a private address (RFC 1918, loopback): the keys may then be fetched from one, and a rule may name a plain-http issuer on a loopback host, for testing. Off by default, so keys are fetched from public addresses over https only. Cloud metadata addresses stay blocked either way.

### Dependency and toolchain updates

No dependency or toolchain bump between v0.14.0 and v0.15.0.

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.14.0 and v0.15.0 is marked as a security fix.
<!-- /earnie:stable-changes -->

