# Earnie v0.10.0

Released 2026-11-05.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.10.0`
- `ghcr.io/scanoss/earnie/earnie-web:v0.10.0`

<!-- earnie:stable-changes -->
## Changes since v0.9.0

For an admin moving from v0.9.0 to v0.10.0.

### Weekly releases included

- v0.10.0

### What's new

**Command-line client**

- Add earnie check to check files and folders once

**Scans**

- Return what a Self-check found

**Web interface**

- Noto Sans and navy ink from earnie.dev, Newsreader kept for titles
- List what a Self-check found on its run page
- Box settings rows and put each control on the right edge
- Raise structural contrast in both themes

### Fixes

**Command-line client**

- Scan staged reports its own timeout, not the pre-commit hook's

**Gitlab**

- Publish a neutral check as a passing commit status, not skipped

**Scans**

- Resolve a licence's copyleft flag from its current SPDX id and the taxonomy
- Show a crypto finding's strongest route first, not its shortest
- Rescan when the effective scan configuration changes

**Web interface**

- Chart dates fit a phone's width, and the chart neutrals go cool
- Show the file when a crypto finding's detail fails to load
- Open a dependency crypto finding's proof instead of its library file

### Upgrade steps

**Review before upgrading:**

- 1 database migration(s) run on start and `install.sh` does not reverse them: take the backup first, and roll back by restoring it.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.10.0`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

No keys added, changed or removed.

### Database migrations

1 new, applied in order by the `migrate` service on start.

**`0076_license_obligations_reresolve`**

```sql
UPDATE scans.licenses SET obligations_resolved_at = NULL;
```

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

Dependency and Go toolchain bumps. Not marked as security fixes, though a bump can carry one.

- Sweep Dependabot's golang digest, bubbletea and web minor bumps

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.9.0 and v0.10.0 is marked as a security fix.
<!-- /earnie:stable-changes -->

