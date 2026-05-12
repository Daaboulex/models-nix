{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

let
  version = "0.11.51";
in
rustPlatform.buildRustPackage {
  pname = "models";
  inherit version;

  src = fetchFromGitHub {
    owner = "arimxyer";
    repo = "models";
    rev = "v${version}";
    hash = "sha256-89D8nisXf6UTd0XHKFhO7WA/bu8hm7dS9FkQOb6R1K8=";
  };

  cargoHash = "sha256-qaXmBkBMbnsJ7LmFhYi04NeIoBwEsyJTNbl81vUjuQg=";

  meta = with lib; {
    description = "TUI and CLI for browsing AI models, benchmarks, and coding agents";
    homepage = "https://github.com/arimxyer/models";
    changelog = "https://github.com/arimxyer/models/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "models";
  };
}
