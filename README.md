# Models CLI (Nix)

<!-- BEGIN generated:badges -->
[![CI](https://github.com/Daaboulex/models-nix/actions/workflows/ci.yml/badge.svg)](https://github.com/Daaboulex/models-nix/actions/workflows/ci.yml)
[![NixOS unstable](https://img.shields.io/badge/NixOS-unstable-78C0E8?logo=nixos&logoColor=white)](https://nixos.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
<!-- END generated:badges -->

Nix flake packaging for [Models](https://github.com/arimxyer/models) by [arimxyer](https://github.com/arimxyer) — a fast TUI and CLI for browsing AI models, benchmarks, and coding agents.

<!-- BEGIN generated:upstream -->
## Upstream

| | |
|---|---|
| **Project** | [arimxyer/models](https://github.com/arimxyer/models) |
| **License** | MIT |
| **Tracked** | GitHub releases |
<!-- END generated:upstream -->

## What Is This?

A Nix flake that builds [Models](https://github.com/arimxyer/models) from source with Level C security:

- **Package integrity** — SRI hashes for source and cargo dependencies, verified on every build
- **CI security** — pinned GitHub Actions (full SHA, not tags), minimal permissions, build-gated PRs
- **Upstream trust** — daily automated version detection, hash recomputation, and test build before PR creation
- **Stale cleanup** — auto-close update PRs open >14 days, delete orphaned branches

Models provides:

- **Models Tab** — Browse 3,000+ AI models across 85+ providers
- **Benchmarks Tab** — Compare performance across 15+ benchmarks
- **Agents Tab** — Track AI coding assistants with version detection

<!-- BEGIN generated:installation -->
## Installation

Add as a flake input:

```nix
{
  inputs.models = {
    url = "github:Daaboulex/models-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

Then add the overlay:

```nix
nixpkgs.overlays = [ inputs.models.overlays.default ];
```
<!-- END generated:installation -->

## Development

```bash
git clone https://github.com/Daaboulex/models-nix
cd models-nix
nix build
./result/bin/models --version
```

## Usage

Launch the TUI:

```bash
models
```

Browse AI models, benchmarks, and coding agents across 85+ providers in an interactive terminal interface.

### Keyboard shortcuts

| Key | Action |
|-----|--------|
| `Tab` | Switch between Models / Benchmarks / Agents tabs |
| `/` | Search / filter |
| `Enter` | View model details |
| `q` | Quit |

### CLI mode

```bash
models --list              # list all models (JSON)
models --search "gpt-4"   # search by name
models --version           # show version
```
## Updates

This repository uses automated daily checks via GitHub Actions to detect new upstream releases. When a new version is found:

1. Source hash is recomputed from the release tarball
2. Cargo dependency hash is recomputed via build error extraction
3. Flake validation and test build must pass
4. A pull request is created with full verification checklist
5. Stale PRs (>14 days) are auto-closed; orphaned branches are deleted

## License

This Nix packaging flake is provided as-is and carries no additional license terms.

The upstream [Models](https://github.com/arimxyer/models) project by [arimxyer](https://github.com/arimxyer) is licensed under the **MIT License**. See the [upstream LICENSE file](https://github.com/arimxyer/models/blob/main/LICENSE) for full terms.

<!-- BEGIN generated:footer -->
---

*Maintained as part of the [Daaboulex](https://github.com/Daaboulex) NixOS ecosystem.*
<!-- END generated:footer -->
