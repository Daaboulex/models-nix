# Models CLI (Nix)

Nix flake packaging for [Models](https://github.com/arimxyer/models) — a fast TUI and CLI for browsing AI models, benchmarks, and coding agents.

![Rust](https://img.shields.io/badge/Rust-2021-blue)
![License MIT](https://img.shields.io/badge/License-MIT-green)
![Version 0.10.2](https://img.shields.io/badge/Version-0.10.2-orange)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-yellow)

## What Is This?

A Nix flake that builds [Models](https://github.com/arimxyer/models) from source. Models provides:

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

This repository uses automated daily checks via GitHub Actions to detect new upstream releases. When a new version is found, a pull request is created automatically with the updated hashes and a verified test build.

## License

This packaging flake is provided as-is. The upstream [Models](https://github.com/arimxyer/models) project is licensed under MIT.
