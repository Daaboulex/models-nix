{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

let
  version = "0.14.0";
in
rustPlatform.buildRustPackage {
  pname = "models";
  inherit version;

  src = fetchFromGitHub {
    owner = "arimxyer";
    repo = "models";
    rev = "v${version}";
    hash = "sha256-42snN+litOrXXP6GbOJOM7fXtGE1MePrdbCAUdDBm7Y=";
  };

  cargoHash = "sha256-/mfR4GOxGuN+GuYDcyyh4kEA5lRhnz/UFtPpgdyBPJA=";

  meta = with lib; {
    description = "TUI and CLI for browsing AI models, benchmarks, and coding agents";
    homepage = "https://github.com/arimxyer/models";
    changelog = "https://github.com/arimxyer/models/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "models";
  };
}
