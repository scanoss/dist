# Earnie v0.18.0

Released 2026-11-26.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.18.0`
- `ghcr.io/scanoss/earnie/earnie-web:v0.18.0`

<!-- earnie:stable-changes -->
## Changes since v0.17.0

For an admin moving from v0.17.0 to v0.18.0.

### Weekly releases included

- v0.18.0

### What's new

**API**

- GET /v1/server/version reports the running version and the release check

**Releasecheck**

- Read server/stable.json and report a missed security fix
- Record the last check result in memory and point the inbox notice at /settings/version

**Web interface**

- A dismissible security-release banner above every shell page for admins
- Flag a security fix on Settings > Version and in the sidebar
- Settings > Version shows the server version and the release check

### Fixes

**Releasecheck**

- A failed stable.json read keeps the last security release
- Link a release that is not the stable to its notes file

**Web interface**

- A banner dismissal in one tab hides it in every open tab
- The sidebar version line wraps its flag instead of truncating the version
- The collapsed version tooltip is one ICU message
- What it sends opens the public outbound network calls page

### Upgrade steps

Nothing in this release needs a manual change.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.18.0`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

No keys added, changed or removed.

### Database migrations

No new migrations.

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

No dependency or toolchain bump between v0.17.0 and v0.18.0.

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.17.0 and v0.18.0 is marked as a security fix.
<!-- /earnie:stable-changes -->

