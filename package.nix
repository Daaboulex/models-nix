{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

let
  version = "0.12.1";
in
rustPlatform.buildRustPackage {
  pname = "models";
  inherit version;

  src = fetchFromGitHub {
    owner = "arimxyer";
    repo = "models";
    rev = "v${version}";
    hash = "sha256-p1GXQhqeQUk+OuyfdP2ftCkfQJuAqt+DHlCN2sWNNfY=";
  };

  cargoHash = "sha256-3fnb3hwUBK1LkjY1JsuSzswBpP81IYXd/tXMYVXMCv4=";

  meta = with lib; {
    description = "TUI and CLI for browsing AI models, benchmarks, and coding agents";
    homepage = "https://github.com/arimxyer/models";
    changelog = "https://github.com/arimxyer/models/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "models";
  };
}
