# Earnie v0.19.0

Released 2026-11-27.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.19.0`
- `ghcr.io/scanoss/earnie/earnie-web:v0.19.0`

<!-- earnie:stable-changes -->
## Changes since v0.18.0

For an admin moving from v0.18.0 to v0.19.0.

### Weekly releases included

- v0.19.0

### What's new

**Breaking changes**

- Scans: Scan crypto with crypto-finder 1.0.2 and the crypto-cards ruleset

### Fixes

**Integrations**

- Check the SCANOSS key against /v3/components/status

**Scans**

- Check the reachability grant before reading the request body

### Upgrade steps

**Review before upgrading:**

- `tenant.env` keys were removed: delete them from your file if you set them.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.19.0`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

**Removed**

- `SCANS_CRYPTO_DEP_WORKERS` (was `0`)
- `SCANS_SANDBOX_FINDINGS_CACHE` (was `true`)
- `SCANS_SANDBOX_FINDINGS_CACHE_HARVEST` (was `true`)
- `SCANS_SANDBOX_FINDINGS_CACHE_MAX_MB` (was `64`)

### Database migrations

No new migrations.

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

No dependency or toolchain bump between v0.18.0 and v0.19.0.

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.18.0 and v0.19.0 is marked as a security fix.
<!-- /earnie:stable-changes -->

