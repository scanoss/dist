# Earnie v0.9.0

Released 2026-11-02.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.9.0`
- `ghcr.io/scanoss/earnie/earnie-web:v0.9.0`

<!-- earnie:stable-changes -->
## Changes since v0.8.0

For an admin moving from v0.8.0 to v0.9.0.

### Weekly releases included

- v0.9.0

### What's new

**Integrations**

- Log the plain http SCM hosts an operator allowed at start-up

**Web interface**

- Show when a GitLab or GitHub connection uses plain http

### Fixes

**Scans**

- Keep the scan when an unkeyed commit-ingest is retried
- Idle sweep reclaims receiving uploads without a live progress row

### Upgrade steps

Nothing in this release needs a manual change.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.9.0`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

No keys added, changed or removed.

### Database migrations

No new migrations.

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

Dependency and Go toolchain bumps. Not marked as security fixes, though a bump can carry one.

- Clear the open Dependabot alerts (Go, web tooling, ai-finder lock)

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.8.0 and v0.9.0 is marked as a security fix.
<!-- /earnie:stable-changes -->

