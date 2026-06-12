{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

let
  version = "0.12.0";
in
rustPlatform.buildRustPackage {
  pname = "models";
  inherit version;

  src = fetchFromGitHub {
    owner = "arimxyer";
    repo = "models";
    rev = "v${version}";
    hash = "sha256-a0iBF0gkC20AxOVNCy9fz5k59Y0wcsoPdPWPHuihJcE=";
  };

  cargoHash = "sha256-5vQwpXBj/AWGg0ovsY8xLU/3NTlinpx7lv0gngRxyig=";

  meta = with lib; {
    description = "TUI and CLI for browsing AI models, benchmarks, and coding agents";
    homepage = "https://github.com/arimxyer/models";
    changelog = "https://github.com/arimxyer/models/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "models";
  };
}
