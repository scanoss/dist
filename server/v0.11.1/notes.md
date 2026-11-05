# Earnie v0.11.1

Released 2026-11-05.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.11.1`
- `ghcr.io/scanoss/earnie/earnie-web:v0.11.1`

<!-- earnie:stable-changes -->
## Changes since v0.11.0

For an admin moving from v0.11.0 to v0.11.1.

### Weekly releases included

- v0.11.1

### What's new

No user-facing changes.

### Fixes

**Web interface**

- The shell renders on the server again under Node 20

### Upgrade steps

Nothing in this release needs a manual change.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.11.1`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

No keys added, changed or removed.

### Database migrations

No new migrations.

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

No dependency or toolchain bump between v0.11.0 and v0.11.1.

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.11.0 and v0.11.1 is marked as a security fix.
<!-- /earnie:stable-changes -->

