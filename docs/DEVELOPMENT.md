# Development

```bash
git clone https://github.com/Daaboulex/models-nix
cd models-nix
nix build
./result/bin/models --version
```

`nix flake check` includes the flake's `smoke` check, which runs
`models --version` from the built package.

The flake's `nixpkgs` input follows `nixos-unstable`. The CI workflow runs on
every push to `main` and on every pull request.

## Upstream

Upstream is [arimxyer/models](https://github.com/arimxyer/models), MIT
licensed. New versions are tracked through its GitHub releases, as
[.github/update.json](../.github/update.json) declares.

## Updates

This repository uses automated daily checks via GitHub Actions to detect new
upstream releases. When a new version is found:

1. Source hash is recomputed from the release tarball
2. Cargo dependency hash is recomputed via build error extraction
3. The flake is evaluated and the package is built and verified
   (`models --version`)
4. On success, the bump is committed and pushed to `main`
5. On failure, an `update-failed` issue is opened with the build log and a
   recovery branch

Weekly maintenance refreshes [flake.lock](../flake.lock) (pushing only if the
result still builds) and deletes orphaned update branches older than 30 days.
