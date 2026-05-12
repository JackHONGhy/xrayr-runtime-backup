# XrayR Runtime Backup

This repository stores a sanitized XrayR 0.9.4 Linux amd64 runtime backup.

## Artifact

- `xrayr-0.9.4-linux-amd64-default-config.tar.gz`
- `xrayr-manager.sh`
- SHA256: `2376ab435eee70e31b9553423865f37289b3e438bb79f01f90f7b49ea91825ff`

## One-Line Install

```bash
bash <(curl -Ls https://raw.githubusercontent.com/JackHONGhy/xrayr-runtime-backup/master/install.sh)
```

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
