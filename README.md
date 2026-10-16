# SCANOSS distribution

Release artifacts for self-hosted SCANOSS products, served at
[get.earnie.dev](https://get.earnie.dev) by GitHub Pages. Nothing here is
built in this repository: `release.yml` in `scanoss/earnie` publishes each
release.

## Earnie server

Install or upgrade a self-hosted Earnie on a Linux host with Docker:

```sh
curl -fsSL https://get.earnie.dev/server/install.sh | sh
```

The script checks Docker Engine 29 or later and the compose plugin, downloads
the bundle for the newest release into `./earnie-vX.Y.Z/`, verifies its
checksum, pulls the Earnie images from `ghcr.io` (public) and runs the bundle's
`./install.sh`. `curl -fsSL https://get.earnie.dev/server/install.sh | EARNIE_VERSION=vX.Y.Z sh`
installs that release instead of the newest (the variable goes on the `sh`
side of the pipe); `EARNIE_TENANT_ENV=/path/to/tenant.env` copies a filled configuration
into the bundle directory first. How to configure and run the bundle:
[Installing Earnie](https://docs.scanoss.com/en/latest/earnie/self-hosting/installation).

| Path | Content |
|---|---|
| `server/install.sh` | the bootstrapper above |
| `server/latest` | the newest release's version, e.g. `v0.4.4` |
| `server/vX.Y.Z/earnie-bundle-vX.Y.Z.tar.gz` | the compose bundle, extracts to `earnie-vX.Y.Z/` |
| `server/vX.Y.Z/earnie-bundle-vX.Y.Z.sha256` | its SHA-256, for `sha256sum -c` |
| `server/vX.Y.Z/notes.md` | the release notes |

The bundle here is gzip-compressed, so a host needs only `tar`. The same
bundle and the offline image archive are on the SCANOSS SFTP server as
`.tar.zst` for hosts without internet access.

## Earnie CLI

The CLI installer will move here under `cli/`. Until then it is at
[scanoss/earnie-cli](https://github.com/scanoss/earnie-cli).
