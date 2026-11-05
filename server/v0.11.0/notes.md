# Earnie v0.11.0

Released 2026-11-05.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.11.0`
- `ghcr.io/scanoss/earnie/earnie-web:v0.11.0`

<!-- earnie:stable-changes -->
## Changes since v0.10.0

For an admin moving from v0.10.0 to v0.11.0.

### Weekly releases included

- v0.11.0

### What's new

**Integrations**

- Report a GitLab merge request result as an external status check

### Fixes

**Scans**

- A dependency cut short by a limit is not complete crypto evidence

### Upgrade steps

**Review before upgrading:**

- 1 database migration(s) run on start and `install.sh` does not reverse them: take the backup first, and roll back by restoring it.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.11.0`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

No keys added, changed or removed.

### Database migrations

1 new, applied in order by the `migrate` service on start.

**`0150_pr_check_placement`**

```sql
ALTER TABLE public.project_pr_feedback_settings
  ADD COLUMN check_placement TEXT NOT NULL DEFAULT 'commit_status'
    CHECK (check_placement IN ('commit_status', 'status_check', 'both'));

ALTER TABLE public.org_pr_feedback_settings
  ADD COLUMN check_placement TEXT NOT NULL DEFAULT 'commit_status'
    CHECK (check_placement IN ('commit_status', 'status_check', 'both'));
```

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

Dependency and Go toolchain bumps. Not marked as security fixes, though a bump can carry one.

- Bump crypto-finder to v0.46.1

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.10.0 and v0.11.0 is marked as a security fix.
<!-- /earnie:stable-changes -->

