# Earnie v0.11.8

Released 2026-11-13.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.11.8`
- `ghcr.io/scanoss/earnie/earnie-web:v0.11.8`

<!-- earnie:stable-changes -->
## Changes since v0.11.7

For an admin moving from v0.11.7 to v0.11.8.

### Weekly releases included

- v0.11.8

### What's new

**Crypto**

- Take the post-quantum verdict from the shared PQC dataset

### Fixes

**Crypto**

- Keep the hybrid a post-quantum family is paired with, on PQC dataset 1.1.0

### Upgrade steps

Nothing in this release needs a manual change.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.11.8`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

No keys added, changed or removed.

### Database migrations

No new migrations.

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

No dependency or toolchain bump between v0.11.7 and v0.11.8.

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.11.7 and v0.11.8 is marked as a security fix.
<!-- /earnie:stable-changes -->

