{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

let
  version = "0.12.3";
in
rustPlatform.buildRustPackage {
  pname = "models";
  inherit version;

  src = fetchFromGitHub {
    owner = "arimxyer";
    repo = "models";
    rev = "v${version}";
    hash = "sha256-MlklSOkRmg4uNsFGluiJYo7nPoVs0R2ixTwFMUuNdLk=";
  };

  cargoHash = "sha256-0BIOPwTlX8wPcI38x5eOyY4bPBfkgNChm1thqLEND5c=";

  meta = with lib; {
    description = "TUI and CLI for browsing AI models, benchmarks, and coding agents";
    homepage = "https://github.com/arimxyer/models";
    changelog = "https://github.com/arimxyer/models/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "models";
  };
}
