{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

let
  version = "0.11.3";
in
rustPlatform.buildRustPackage {
  pname = "models";
  inherit version;

  src = fetchFromGitHub {
    owner = "arimxyer";
    repo = "models";
    rev = "v${version}";
    hash = "sha256-APLJwwn25XmIm1tfJewqbwTFmUpYPTZEsSdy0FHhdb8=";
  };

  cargoHash = "sha256-ArIFhwf8+pTP7VzgCDAjtOJjRtVDOqSEjArvMW1ZR1s=";

  meta = with lib; {
    description = "TUI and CLI for browsing AI models, benchmarks, and coding agents";
    homepage = "https://github.com/arimxyer/models";
    changelog = "https://github.com/arimxyer/models/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "models";
  };
}
