{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

let
  version = "0.11.52";
in
rustPlatform.buildRustPackage {
  pname = "models";
  inherit version;

  src = fetchFromGitHub {
    owner = "arimxyer";
    repo = "models";
    rev = "v${version}";
    hash = "sha256-RFyJtZ+W6DV5eBU28Lv8vVAm90yHQW+VCvnph3QlRuk=";
  };

  cargoHash = "sha256-RDOnHAI0jp78gX3ZSkCAaW+T5PuP6UAM6QA6908In2s=";

  meta = with lib; {
    description = "TUI and CLI for browsing AI models, benchmarks, and coding agents";
    homepage = "https://github.com/arimxyer/models";
    changelog = "https://github.com/arimxyer/models/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "models";
  };
}
