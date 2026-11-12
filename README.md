# Models CLI (Nix)

Nix flake packaging for [Models](https://github.com/arimxyer/models) by
[arimxyer](https://github.com/arimxyer), a TUI and CLI for browsing AI models,
benchmarks, and coding agents. The flake builds Models from source and offers
it as a package and as an overlay.

It is declared for `x86_64-linux` and `aarch64-linux`. The flake's own check
runs `models --version` and nothing more, so the interface and the subcommands
are not tested here.

## Install

Add the flake:

```nix
{
  inputs.models = {
    url = "github:Daaboulex/models-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

Then add the overlay and install the package. The overlay names the package
`models-cli`. The program it installs is `models`.

```nix
{
  nixpkgs.overlays = [ inputs.models.overlays.default ];
  environment.systemPackages = [ pkgs.models-cli ];
}
```

To run it once without installing:

```bash
nix run github:Daaboulex/models-nix
```

## Use

Launch the TUI:

```bash
models
```

Browse AI models, benchmarks, and coding agents in an interactive terminal
interface. It has three tabs.

| Tab | What it is for |
|---|---|
| Models | Browse AI models across providers |
| Benchmarks | Compare performance across benchmarks |
| Agents | Track AI coding assistants with version detection |

Keyboard shortcuts:

| Key | Action |
|---|---|
| `Tab` | Switch between the Models, Benchmarks and Agents tabs |
| `/` | Search or filter |
| `Enter` | View model details |
| `q` | Quit |

CLI mode, without the interface:

| Command | What it does |
|---|---|
| `models list` | List all models |
| `models search "gpt-4"` | Search by name |
| `models --version` | Show the version |

## More

- [docs/DEVELOPMENT.md](docs/DEVELOPMENT.md): building from a clone, the
  check, how new upstream releases and the lock file are picked up

## License

This packaging flake is [MIT](./LICENSE) licensed. Upstream [models](https://github.com/arimxyer/models) is MIT.

The upstream [Models](https://github.com/arimxyer/models) project by [arimxyer](https://github.com/arimxyer) is licensed under the **MIT License**. See the [upstream LICENSE file](https://github.com/arimxyer/models/blob/main/LICENSE) for full terms.
