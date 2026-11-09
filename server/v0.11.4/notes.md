# Earnie v0.11.4

<!-- earnie:stable -->
**v0.11.4 is a stable release.** Promoted on 2026-11-09. Upgrade test: https://github.com/scanoss/earnie/actions/runs/42613073433. Supported until the second stable release after it is promoted.
<!-- /earnie:stable -->

Released 2026-11-09.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.11.4`
- `ghcr.io/scanoss/earnie/earnie-web:v0.11.4`

<!-- earnie:stable-changes -->
## Changes since v0.11.3

For an admin moving from v0.11.3 to v0.11.4.

### Weekly releases included

- v0.11.4

### What's new

No user-facing changes.

### Fixes

**Integrations**

- Accept GitHub deliveries on the pre-host-routing webhook URL; resend only the last day

**Kev**

- Only the refreshing process reports catalog age, and a 304 counts as current

**Scans**

- Read scan settings only from the repo root; back the reconcile sweep off failing heads

### Upgrade steps

Nothing in this release needs a manual change.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.11.4`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

No keys added, changed or removed.

### Database migrations

No new migrations.

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

No dependency or toolchain bump between v0.11.3 and v0.11.4.

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.11.3 and v0.11.4 is marked as a security fix.
<!-- /earnie:stable-changes -->
