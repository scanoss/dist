# Earnie v0.11.5

Released 2026-11-11.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.11.5`
- `ghcr.io/scanoss/earnie/earnie-web:v0.11.5`

<!-- earnie:stable-changes -->
## Changes since v0.11.4

For an admin moving from v0.11.4 to v0.11.5.

### Weekly releases included

- v0.11.5

### What's new

No user-facing changes.

### Fixes

**Scans**

- Stop concurrent scans deadlocking the licences stage

### Upgrade steps

Nothing in this release needs a manual change.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.11.5`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

No keys added, changed or removed.

### Database migrations

No new migrations.

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

No dependency or toolchain bump between v0.11.4 and v0.11.5.

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.11.4 and v0.11.5 is marked as a security fix.
<!-- /earnie:stable-changes -->

