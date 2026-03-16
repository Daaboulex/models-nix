#!/usr/bin/env bash
set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[INFO]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*" >&2; }

# Fetch latest release from GitHub API with retries
fetch_latest_release() {
    local url="https://api.github.com/repos/arimxyer/models/releases/latest"
    local retry_delays=(2 4 8)
    local response

    for delay in "${retry_delays[@]}"; do
        response=$(curl -sL "$url") && break
        warn "Request failed, retrying in ${delay}s..."
        sleep "$delay"
    done

    if [[ -z "$response" ]]; then
        error "Failed to fetch release metadata after retries"
        exit 1
    fi

    echo "$response"
}

# Get current version from flake.nix
get_current_version() {
    grep 'version = "' flake.nix | head -1 | sed 's/.*version = "\(.*\)".*/\1/'
}

# Compare semantic versions (returns 0 if $1 > $2)
version_gt() {
    test "$(printf '%s\n' "$1" "$2" | sort -V | tail -1)" != "$2"
}

main() {
    log "Checking for Models CLI updates..."

    local release_json
    release_json=$(fetch_latest_release)

    local new_version
    new_version=$(echo "$release_json" | jq -r '.tag_name' | sed 's/^v//')

    if [[ -z "$new_version" || "$new_version" == "null" ]]; then
        error "Could not parse version from release metadata"
        exit 1
    fi

    local current_version
    current_version=$(get_current_version)

    log "Current version: $current_version"
    log "Latest version:  $new_version"

    if [[ "$current_version" == "$new_version" ]]; then
        log "Already up to date"
        echo "updated=false" >> "${GITHUB_OUTPUT:-/dev/null}"
        exit 0
    fi

    if ! version_gt "$new_version" "$current_version"; then
        warn "Latest version ($new_version) is not newer than current ($current_version)"
        echo "updated=false" >> "${GITHUB_OUTPUT:-/dev/null}"
        exit 0
    fi

    log "New version available: $new_version"

    # Compute new source hash
    log "Computing source hash..."
    local src_url="https://github.com/arimxyer/models/archive/refs/tags/v${new_version}.tar.gz"
    local nix_hash
    nix_hash=$(nix-prefetch-url --unpack "$src_url" 2>/dev/null)
    local sri_hash
    sri_hash=$(nix hash convert --hash-algo sha256 --to sri "$nix_hash")

    log "New source hash: $sri_hash"

    # Update flake.nix
    log "Updating flake.nix..."
    sed -i "s/version = \"${current_version}\"/version = \"${new_version}\"/" flake.nix
    sed -i "s|hash = \"sha256-[^\"]*\"|hash = \"${sri_hash}\"|" flake.nix
    # Reset cargoHash to force recomputation
    sed -i 's|cargoHash = "sha256-[^"]*"|cargoHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="|' flake.nix

    # Update flake.lock
    nix flake update 2>/dev/null || true

    # Get correct cargo hash from build error
    log "Computing cargo hash (this may take a while)..."
    local build_output
    build_output=$(nix build .#default 2>&1 || true)
    local cargo_hash
    cargo_hash=$(echo "$build_output" | grep 'got:' | head -1 | awk '{print $2}')

    if [[ -z "$cargo_hash" ]]; then
        error "Failed to extract cargo hash from build output"
        exit 1
    fi

    sed -i "s|cargoHash = \"sha256-[^\"]*\"|cargoHash = \"${cargo_hash}\"|" flake.nix

    # Validate flake
    log "Validating flake..."
    if ! nix flake check --no-build 2>/dev/null; then
        error "Flake validation failed"
        exit 1
    fi

    # Test build
    log "Running test build (this may take a while)..."
    if ! nix build .#default --no-link 2>/dev/null; then
        error "Test build failed"
        exit 1
    fi

    log "Successfully updated to $new_version"

    # Update README badge
    sed -i "s/Version-[0-9.]*-orange/Version-${new_version}-orange/" README.md

    # Export for GitHub Actions
    {
        echo "updated=true"
        echo "new_version=$new_version"
        echo "current_version=$current_version"
    } >> "${GITHUB_OUTPUT:-/dev/null}"
}

main "$@"
