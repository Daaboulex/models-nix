{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

let
  version = "0.10.2";
in
rustPlatform.buildRustPackage {
  pname = "models";
  inherit version;

  src = fetchFromGitHub {
    owner = "arimxyer";
    repo = "models";
    rev = "v${version}";
    hash = "sha256-I8dPV6Nbg62UmJcBQSpuHwGY/3b0jt1vStaS5PYdS6Y=";
  };

  cargoHash = "sha256-b2QlNecTvV09t7qEx0R8MuuqlCmXMra2bPDK/JPLO3o=";

  meta = with lib; {
    description = "TUI and CLI for browsing AI models, benchmarks, and coding agents";
    homepage = "https://github.com/arimxyer/models";
    changelog = "https://github.com/arimxyer/models/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "models";
  };
}
