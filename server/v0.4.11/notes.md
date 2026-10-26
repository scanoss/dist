# Earnie v0.4.11

<!-- earnie:stable -->
**v0.4.11 is a stable release.** Promoted on 2026-10-26. Upgrade test: https://github.com/scanoss/earnie/actions/runs/40382211149. Supported until the second stable release after it is promoted.
<!-- /earnie:stable -->

Released 2026-10-26.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.4.11`
- `ghcr.io/scanoss/earnie/earnie-web:v0.4.11`

On-prem image archive for v0.4.11. Follow docs/deploy/releasing.md, section 6.

<!-- earnie:stable-changes -->
## Changes since v0.4.10

For an admin moving from v0.4.10 to v0.4.11.

### Weekly releases included

- v0.4.11

### What's new

No user-facing changes.

### Fixes

No user-facing changes.

### Upgrade steps

Nothing in this release needs a manual change.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.4.11`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

**Added**

- `EARNIE_PREVIEW_FEATURES`, default empty. Features that are finished but not generally available yet, comma-separated without spaces. Empty turns them all off. Listed here, a feature turns on for the whole deployment after the next restart. The names this release knows: cra (CRA Article 14 reporting). A name the release does not know stops the api at start-up; remove a name before upgrading to the release that retires it. Example, to turn CRA reporting on: cra

### Database migrations

No new migrations.

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

No dependency or toolchain bump between v0.4.10 and v0.4.11.

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.4.10 and v0.4.11 is marked as a security fix.
<!-- /earnie:stable-changes -->
