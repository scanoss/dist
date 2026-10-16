#!/bin/sh
# Earnie server bootstrapper.
#
#   curl -fsSL https://get.earnie.dev/server/install.sh | sh
#
# Downloads the bundle for one Earnie release into ./earnie-vX.Y.Z/, verifies
# its checksum, pulls the Earnie images from ghcr.io and runs the bundle's own
# ./install.sh. Needs curl, tar, sha256sum and Docker Engine 29 or later with
# the compose plugin, run by a user in the docker group.
#
#   EARNIE_VERSION     the release to install, e.g. v0.4.4; default: the newest.
#                      Set it on the sh side: curl ... | EARNIE_VERSION=v0.4.4 sh
#   EARNIE_TENANT_ENV  a filled tenant.env to copy into the bundle directory,
#                      e.g. the one from the release you are upgrading from
#   EARNIE_DIST_URL    where the releases are; default https://get.earnie.dev
#
# Without a terminal the bundle's installer is not run, and the script prints
# the command to run instead. The bundle directory is never overwritten: a
# release that is already extracted is left alone.
set -eu

default_dist="https://get.earnie.dev"
fallback_dist="https://scanoss.github.io/dist"

die() { echo "error: $*" >&2; exit 1; }
say() { echo "==> $*"; }

need() {
  for tool in "$@"; do
    command -v "$tool" >/dev/null 2>&1 || die "$tool is required"
  done
}

need_docker() {
  command -v docker >/dev/null 2>&1 \
    || die "docker is required: install Docker Engine 29 or later from https://docs.docker.com/engine/install/"
}

check_docker() {
  need_docker
  server="$(docker version --format '{{.Server.Version}}' 2>/dev/null)" \
    || die "cannot talk to the Docker daemon: is Docker running, and is $(id -un) in the docker group?"
  major="${server%%.*}"
  [ "$major" -ge 29 ] 2>/dev/null \
    || die "Docker Engine $server is too old: Earnie needs 29 or later, from https://docs.docker.com/engine/install/"
  docker compose version >/dev/null 2>&1 || die "the docker compose plugin is required"
}

# fetch URL FILE: 0 when downloaded, 1 otherwise.
fetch() { curl -fsSL --connect-timeout 15 --retry 3 -o "$2" "$1"; }

pick_dist() {
  if [ -n "${EARNIE_DIST_URL:-}" ]; then
    dist="${EARNIE_DIST_URL%/}"
    fetch "$dist/server/latest" "$tmp/latest" || die "cannot reach $dist/server/latest"
    return
  fi
  dist="$default_dist"
  if ! fetch "$dist/server/latest" "$tmp/latest"; then
    dist="$fallback_dist"
    fetch "$dist/server/latest" "$tmp/latest" || die "cannot reach $default_dist or $fallback_dist"
  fi
}

main() {
  need curl tar sha256sum
  check_docker

  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT HUP INT TERM

  pick_dist
  version="${EARNIE_VERSION:-$(tr -d '[:space:]' < "$tmp/latest")}"
  printf '%s' "$version" | grep -Eq '^v[0-9]+\.[0-9]+\.[0-9]+$' || die "not a release version: $version"

  dir="earnie-$version"
  [ ! -e "$dir" ] || die "./$dir already exists; run: cd $dir && ./install.sh"

  bundle="earnie-bundle-$version.tar.gz"
  url="$dist/server/$version"
  say "downloading $bundle from $url"
  fetch "$url/$bundle" "$tmp/$bundle" \
    || die "no release $version at $dist/server/$version/ (the newest is $(tr -d '[:space:]' < "$tmp/latest"))"
  fetch "$url/earnie-bundle-$version.sha256" "$tmp/$bundle.sha256" || die "no checksum at $url/earnie-bundle-$version.sha256"
  (cd "$tmp" && sha256sum -c "$bundle.sha256" >/dev/null) || die "checksum mismatch for $bundle"

  tar -xzf "$tmp/$bundle"
  [ -x "$dir/install.sh" ] || die "the bundle did not extract to ./$dir"
  if [ -n "${EARNIE_TENANT_ENV:-}" ]; then
    [ -f "$EARNIE_TENANT_ENV" ] || die "EARNIE_TENANT_ENV: no such file: $EARNIE_TENANT_ENV"
    cp "$EARNIE_TENANT_ENV" "$dir/tenant.env"
    chmod 600 "$dir/tenant.env"
  fi
  say "bundle extracted to ./$dir"

  say "pulling the Earnie $version images"
  for image in earnie-api earnie-web; do
    docker pull --quiet "ghcr.io/scanoss/earnie/$image:$version"
  done

  cd "$dir"
  if ( : < /dev/tty ) 2>/dev/null; then
    say "running ./install.sh in $(pwd)"
    rm -rf "$tmp"
    exec ./install.sh < /dev/tty
  fi
  say "ready. Next: cd $dir && ./install.sh"
}

main "$@"
