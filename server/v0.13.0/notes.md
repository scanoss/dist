# Earnie v0.13.0

Released 2026-11-16.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.13.0`
- `ghcr.io/scanoss/earnie/earnie-web:v0.13.0`

<!-- earnie:stable-changes -->
## Changes since v0.12.0

For an admin moving from v0.12.0 to v0.13.0.

### Weekly releases included

- v0.13.0

### What's new

**Crypto**

- Derive and serve the PQC migration priority of each vulnerable finding

**Notifications**

- Guided setup screens for every channel kind

**Policies**

- Show where a policy fact came from in the violation detail and the PR comment

**Scans**

- Make snippet auto-resolve generally available
- Make snippet classification generally available
- Republish open requests' error checks when When a scan fails changes
- Limit dependency resolution depth or keep declared only

**Web interface**

- Show, sort and filter the migration priority on Cryptography
- Search, filter and sort Cryptography's Libraries tab
- Group Cryptography's Needs attention by policy and shorten its rows
- Dependency resolution in Scan configuration, and the limit on the Dependencies page
- Capability names instead of engine names, neutral export identity

**General**

- Show the post-quantum migration priorities on the Cryptography overview
- Optional Hugging Face token per organization to verify gated models

### Fixes

**API**

- Require effective_snippet_auto_resolve on the project read

**Command-line client**

- Print the JSON envelope for a wrong argument count under --json

**Merge guard**

- Accept a writer's merge-risk assessment on a Dependabot or Renovate PR

**Notifications**

- Drop kev_sweep_baselines and stop a stuck scan silencing new-vulnerability notices

**Scans**

- Restore the SBOM import default enrichments text

**Web interface**

- Make Cryptography match the approved mockups
- Dashboard blocked row says Request approval, not exception

### Upgrade steps

**Review before upgrading:**

- 4 database migration(s) run on start and `install.sh` does not reverse them: take the backup first, and roll back by restoring it.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.13.0`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

No keys added, changed or removed.

### Database migrations

4 new, applied in order by the `migrate` service on start.

**`0152_scan_configuration_dependency_resolution`**

```sql
ALTER TABLE public.org_scan_configurations
  ADD COLUMN dependency_resolution JSONB NOT NULL DEFAULT '{}'::jsonb;

ALTER TABLE public.project_scan_configurations
  ADD COLUMN dependency_resolution JSONB NOT NULL DEFAULT '{}'::jsonb;
```

**`0153_huggingface_tokens`**

```sql
CREATE TABLE public.huggingface_tokens (
  organization_id UUID        PRIMARY KEY REFERENCES public.organizations (id) ON DELETE CASCADE,
  token_enc       BYTEA       NOT NULL CHECK (octet_length(token_enc) > 0),
  token_key_ref   TEXT        NOT NULL CHECK (token_key_ref <> ''),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

**`0003_root_depth_limit`**

```sql
ALTER TABLE depgraph.roots ADD COLUMN depth_limit INTEGER NULL;
ALTER TABLE depgraph.roots ADD CONSTRAINT roots_depth_limit_positive CHECK (depth_limit >= 1) NOT VALID;
```

**`0009_drop_kev_sweep_baselines`**

```sql
DROP TABLE IF EXISTS notifications.kev_sweep_baselines;
```

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

Dependency and Go toolchain bumps. Not marked as security fixes, though a bump can carry one.

- Bump the web-minor-patch group across 1 directory with 13 updates
- Bump github.com/jackc/pgx/v5 from 5.12.0 to 5.13.0 in /pkg/triagesdk in the go-minor-patch group
- Bump github.com/oapi-codegen/runtime from 1.8.0 to 1.9.0 in /pkg/earnieclient in the go-minor-patch group
- Bump alpine from `2e0b81d` to `49340b3` in the docker-bases group across 1 directory
- Bump the go-minor-patch group across 1 directory with 5 updates
- Bump @vitejs/plugin-react from 5.2.0 to 6.2.1 in /web
- Split the cmd/earnie-api tests across two legs by test name

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.12.0 and v0.13.0 is marked as a security fix.
<!-- /earnie:stable-changes -->

