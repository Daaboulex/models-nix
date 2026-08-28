{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

let
  version = "0.14.1";
in
rustPlatform.buildRustPackage {
  pname = "models";
  inherit version;

  src = fetchFromGitHub {
    owner = "arimxyer";
    repo = "models";
    rev = "v${version}";
    hash = "sha256-pnjYOeiyN13eHmU7y7HRxcOldDqry8M/3p7JEGes1Qg=";
  };

  cargoHash = "sha256-DCjX3BTrW45CTMjAo6ednQdDpPAHWqt0ReS3h4SOxVc=";

  meta = with lib; {
    description = "TUI and CLI for browsing AI models, benchmarks, and coding agents";
    homepage = "https://github.com/arimxyer/models";
    changelog = "https://github.com/arimxyer/models/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "models";
  };
}
