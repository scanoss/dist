# Earnie v0.8.0

Released 2026-11-02.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.8.0`
- `ghcr.io/scanoss/earnie/earnie-web:v0.8.0`

## Earnie v0.8.0

Fewer ways for Earnie itself to block a merge, and self-hosted installs that survive restarts.

### What's new

**A failed scan can stay advisory**
- Pull-request feedback has a new setting, **When a scan fails**: Block (the default, unchanged) or Advisory.
- With Advisory, a scan that ends without a policy verdict (a scanning error, a rate limit, retries used up) publishes "Evaluation failed" as a non-blocking check: neutral on GitHub, skipped on GitLab. Blocked by policy and Approval required still block.
- An organization can set it for every project and lock it.
- On GitLab, if Earnie's status is the only job in a pipeline, the pipeline is skipped. With "Pipelines must succeed", also turn on "Skipped pipelines are considered successful".

**Plain http GitLab and GitHub Enterprise Server hosts**
- A self-hosted operator can allow named GitLab or GitHub Enterprise Server hosts that serve plain http, with `EARNIE_SCM_INSECURE_HTTP_HOSTS` (empty by default, which allows none). The token and the code travel in clear text to a listed host, so list one only on a network you control.

### Fixes
- A restart no longer fails running scans. When an Earnie server stops, scans still running are handed to another server within seconds and keep their retry count. A retried scan keeps the results its first attempt saved, and a repository fetch cut short by the stop is retried instead of failing.
- The shutdown wait is configurable with `EARNIE_SHUTDOWN_DRAIN_SECONDS` (default 60). Set it below your runtime's stop grace period, leaving about 30 seconds for open requests.
- The High-severity CVEs figure reads the source scan's count.
- A disabled onboarding snapshot no longer shows as loading.
- The CLI refuses `export --scan` with a scan from another project.
