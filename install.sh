#!/usr/bin/env bash
set -euo pipefail

REPO="${XRAYR_REPO:-JackHONGhy/xrayr-runtime-backup}"
BRANCH="${XRAYR_BRANCH:-master}"
ARCHIVE="xrayr-0.9.4-linux-amd64-default-config.tar.gz"
MANAGER="xrayr-manager.sh"
SHA256="2376ab435eee70e31b9553423865f37289b3e438bb79f01f90f7b49ea91825ff"
BASE_URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}"
TMP_DIR="$(mktemp -d)"

cleanup() {
  rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

if [ "$(id -u)" -ne 0 ]; then
  echo "This installer must be run as root." >&2
  exit 1
fi

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

need_cmd curl
need_cmd tar
need_cmd sha256sum
need_cmd systemctl

echo "Downloading XrayR runtime package..."
curl -fL --retry 3 --connect-timeout 15 \
  -o "${TMP_DIR}/${ARCHIVE}" \
  "${BASE_URL}/${ARCHIVE}"
curl -fL --retry 3 --connect-timeout 15 \
  -o "${TMP_DIR}/${MANAGER}" \
  "${BASE_URL}/${MANAGER}"

echo "${SHA256}  ${TMP_DIR}/${ARCHIVE}" | sha256sum -c -

if systemctl is-active --quiet XrayR 2>/dev/null; then
  echo "Stopping existing XrayR service..."
  systemctl stop XrayR
fi

echo "Installing files..."
tar -xzf "${TMP_DIR}/${ARCHIVE}" -C /
chmod +x /usr/local/XrayR/XrayR
install -m 0755 "${TMP_DIR}/${MANAGER}" /usr/bin/XrayR
ln -sf /usr/bin/XrayR /usr/bin/xrayr

systemctl daemon-reload
systemctl enable XrayR

echo
echo "XrayR installed."
echo "Edit /etc/XrayR/config.yml before starting the service:"
echo "  nano /etc/XrayR/config.yml"
echo
echo "Then start it with:"
echo "  systemctl start XrayR"
