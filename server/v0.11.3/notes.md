# Earnie v0.11.3

Released 2026-11-08.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.11.3`
- `ghcr.io/scanoss/earnie/earnie-web:v0.11.3`

<!-- earnie:stable-changes -->
## Changes since v0.11.2

For an admin moving from v0.11.2 to v0.11.3.

### Weekly releases included

- v0.11.3

### What's new

No user-facing changes.

### Fixes

**Policies**

- Give policies finding.match_percent from oss-diff evidence

**Scans**

- Mark a dependency dev when its manifest declares it for development
- CLI and browser folder uploads work across several api replicas
- Skip a manifest that fails to parse instead of dropping every dependency
- Honor on_failure_only on GitLab merge requests
- Install Node and Python dependencies in the crypto sandbox
- Keep crypto coverage full when an occurrence is duplicated
- Sweep crypto findings of every dependency the run observed completely

### Upgrade steps

**Review before upgrading:**

- 1 database migration(s) run on start and `install.sh` does not reverse them: take the backup first, and roll back by restoring it.

Follow [Upgrading and Backing Up](https://docs.scanoss.com/en/latest/earnie/self-hosting/upgrading-and-backups): back up the data directory and `tenant.env`, run the bootstrapper with `EARNIE_VERSION=v0.11.3`, then the new bundle's `install.sh`, which keeps your `tenant.env` and migrates the database on start.

### tenant.env changes

No keys added, changed or removed.

### Database migrations

1 new, applied in order by the `migrate` service on start.

**`0077_scan_ingest_received_files`**

```sql
CREATE TABLE scans.scan_ingest_received_files (
    scan_id    UUID   NOT NULL REFERENCES scans.scans(id) ON DELETE CASCADE,
    path       TEXT   NOT NULL,
    sha256     TEXT   NOT NULL,
    size_bytes BIGINT NOT NULL,

    PRIMARY KEY (scan_id, path),
    CONSTRAINT chk_scan_ingest_received_sha256 CHECK (sha256 ~ '^[0-9a-f]{64}$'),
    CONSTRAINT chk_scan_ingest_received_size CHECK (size_bytes >= 0)
);
```

### Outbound network destinations

No new destinations are named in `tenant.env` or the sandbox allowlist. Earnie keeps no other catalogue of destinations, so a new one that code adds is not listed here.

### Dependency and toolchain updates

Dependency and Go toolchain bumps. Not marked as security fixes, though a bump can carry one.

- Bump crypto-finder to v0.46.5
- Bump crypto-finder to v0.46.4

### Security fixes

Changes marked as security fixes. A fix nobody marked is not listed, so an empty list is not a guarantee.

No change between v0.11.2 and v0.11.3 is marked as a security fix.
<!-- /earnie:stable-changes -->

