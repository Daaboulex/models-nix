# Models CLI (Nix)

Nix flake packaging for [Models](https://github.com/arimxyer/models) by [arimxyer](https://github.com/arimxyer) — a fast TUI and CLI for browsing AI models, benchmarks, and coding agents.

![Rust](https://img.shields.io/badge/Rust-2021-blue)
![License MIT](https://img.shields.io/badge/License-MIT-green)
![Version 0.10.2](https://img.shields.io/badge/Version-0.10.2-orange)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-yellow)

## Upstream

This is a **Nix packaging wrapper** — not the original project. All credit for Models CLI goes to:

- **Author**: [arimxyer](https://github.com/arimxyer)
- **Repository**: [github.com/arimxyer/models](https://github.com/arimxyer/models)
- **License**: [MIT](https://github.com/arimxyer/models/blob/main/LICENSE)

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

## Installation

### NixOS (Flake)

Add as a flake input and use the overlay:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    models-nix = {
      url = "github:Daaboulex/models-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, models-nix, ... }: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      modules = [{
        nixpkgs.overlays = [ models-nix.overlays.default ];
        environment.systemPackages = [ pkgs.models-cli ];
      }];
    };
  };
}
```

### Direct Run

```bash
nix run github:Daaboulex/models-nix
```

### Profile Install

```bash
nix profile install github:Daaboulex/models-nix
```

## Development

```bash
git clone https://github.com/Daaboulex/models-nix
cd models-nix
nix build
./result/bin/models --version
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
