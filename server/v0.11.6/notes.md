# Earnie v0.11.6

Released 2026-11-11.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.11.6`
- `ghcr.io/scanoss/earnie/earnie-web:v0.11.6`

<!-- earnie:stable-changes -->
## Changes since v0.11.5

For an admin moving from v0.11.5 to v0.11.6.

### Weekly releases included

- v0.11.6

### What's new

No user-facing changes.

### Fixes

No user-facing changes.

### Upgrade steps

Nothing in this release needs a manual change.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.11.6`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

No keys added, changed or removed.

### Database migrations

No new migrations.

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

Dependency and Go toolchain bumps. Not marked as security fixes, though a bump can carry one.

- Bump crypto-finder to v0.50.1

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

- Go 1.27.4 for GO-2026-6859
<!-- /earnie:stable-changes -->

