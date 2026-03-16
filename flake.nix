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
        pkgs = import nixpkgs { inherit system; };
        version = "0.10.2";
      in
      {
        packages.default = pkgs.rustPlatform.buildRustPackage {
          pname = "models";
          inherit version;

          src = pkgs.fetchFromGitHub {
            owner = "arimxyer";
            repo = "models";
            rev = "v${version}";
            hash = "sha256-I8dPV6Nbg62UmJcBQSpuHwGY/3b0jt1vStaS5PYdS6Y=";
          };

          cargoHash = "sha256-b2QlNecTvV09t7qEx0R8MuuqlCmXMra2bPDK/JPLO3o=";

          meta = with pkgs.lib; {
            description = "TUI and CLI for browsing AI models, benchmarks, and coding agents";
            homepage = "https://github.com/arimxyer/models";
            license = licenses.mit;
            mainProgram = "models";
          };
        };
      }
    )
    // {
      overlays.default = final: prev: {
        models-cli = self.packages.${final.system}.default;
      };
    };
}
