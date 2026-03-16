{
  description = "Nix flake for Models CLI — TUI for browsing AI models, benchmarks, and coding agents";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { localSystem.system = system; };
      in
      {
        packages.default = pkgs.callPackage ./package.nix { };
      }
    )
    // {
      overlays.default = final: prev: {
        models-cli = self.packages.${final.system}.default;
      };
    };
}
