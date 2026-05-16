# XrayR Runtime Backup

This repository stores sanitized XrayR 0.9.4 Linux runtime backups for amd64 and arm64.

## Artifact

- `xrayr-0.9.4-linux-amd64-default-config.tar.gz`
- `xrayr-0.9.4-linux-arm64-default-config.tar.gz`
- `xrayr-manager.sh`
- amd64 SHA256: `2376ab435eee70e31b9553423865f37289b3e438bb79f01f90f7b49ea91825ff`
- arm64 SHA256: `43fdc96a9ff6362bbf3d917ff5adcfb856e67d3d44615a5bed6cf6ea84e30e64`

## One-Line Install

```bash
bash <(curl -Ls https://raw.githubusercontent.com/JackHONGhy/xrayr-runtime-backup/master/install.sh)
```

The installer automatically detects `x86_64/amd64` or `aarch64/arm64` and downloads the matching package.

## Notes

- The active server configuration was replaced with the package default `config.yml` before packaging.
- The archive includes the XrayR binary, default config files, geo data files, and `etc/systemd/system/XrayR.service`.
- The installer installs the original XrayR management script as `xrayr` and `XrayR`.
- Configure `/etc/XrayR/config.yml` on each server before starting the service.

## Basic Restore

```bash
tar -xzf xrayr-0.9.4-linux-amd64-default-config.tar.gz -C /
systemctl daemon-reload
systemctl enable XrayR
systemctl start XrayR
```
