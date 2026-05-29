{
  description = "Nix flake for Models CLI — TUI for browsing AI models, benchmarks, and coding agents";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    std = {
      url = "github:Daaboulex/nix-packaging-standard?ref=v2.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.git-hooks.follows = "git-hooks";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [ inputs.std.flakeModules.base ];

      perSystem =
        { pkgs, self', ... }:
        {
          packages.default = pkgs.callPackage ./package.nix { };

          checks.smoke = pkgs.runCommand "models-smoke" { } ''
            ${self'.packages.default}/bin/models --version > /dev/null
            touch "$out"
          '';
        };

      flake.overlays.default = final: _prev: {
        models-cli = inputs.self.packages.${final.system}.default;
      };
    };
}
