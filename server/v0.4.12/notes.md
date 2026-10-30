# Earnie v0.4.12

<!-- earnie:stable -->
**v0.4.12 is a stable release.** Promoted on 2026-10-30. Upgrade test: https://github.com/scanoss/earnie/actions/runs/41046196404. Supported until the second stable release after it is promoted.
<!-- /earnie:stable -->

Released 2026-10-30.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.4.12`
- `ghcr.io/scanoss/earnie/earnie-web:v0.4.12`

On-prem image archive for v0.4.12. Follow docs/deploy/releasing.md, section 6.

<!-- earnie:stable-changes -->
## Changes since v0.4.11

For an admin moving from v0.4.11 to v0.4.12.

### Weekly releases included

- v0.4.12

### What's new

No user-facing changes.

### Fixes

**Integrations**

- Close the GitLab commit status on the pipeline it was opened on

### Upgrade steps

Nothing in this release needs a manual change.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.4.12`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

No keys added, changed or removed.

### Database migrations

No new migrations.

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

No dependency or toolchain bump between v0.4.11 and v0.4.12.

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.4.11 and v0.4.12 is marked as a security fix.
<!-- /earnie:stable-changes -->
