#!/usr/bin/env bash
set -euo pipefail

# Narra launcher — auto-downloads the correct platform binary from GitHub releases.
# All diagnostic output goes to stderr (stdout is MCP JSON-RPC).

NARRA_VERSION="0.1.0"
REPO="florinutz/narra"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BINARY="$SCRIPT_DIR/narra"

# --- Platform detection ---

detect_target() {
  local os arch
  os="$(uname -s)"
  arch="$(uname -m)"

  case "$os" in
    Linux)  os="unknown-linux-gnu" ;;
    Darwin) os="apple-darwin" ;;
    *)      echo "Unsupported OS: $os" >&2; exit 1 ;;
  esac

  case "$arch" in
    x86_64)  arch="x86_64" ;;
    aarch64|arm64) arch="aarch64" ;;
    *)       echo "Unsupported architecture: $arch" >&2; exit 1 ;;
  esac

  echo "${arch}-${os}"
}

# --- Download ---

download_binary() {
  local target="$1"
  local archive="narra-${target}.tar.gz"
  local url="https://github.com/${REPO}/releases/download/v${NARRA_VERSION}/${archive}"

  echo "Downloading narra v${NARRA_VERSION} for ${target}..." >&2
  echo "  ${url}" >&2

  local tmp_dir
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "$tmp_dir"' EXIT

  if command -v curl &>/dev/null; then
    curl -sL "$url" -o "$tmp_dir/$archive"
  elif command -v wget &>/dev/null; then
    wget -q "$url" -O "$tmp_dir/$archive"
  else
    echo "Error: neither curl nor wget found" >&2
    exit 1
  fi

  tar xzf "$tmp_dir/$archive" -C "$tmp_dir"

  if [ ! -f "$tmp_dir/narra" ]; then
    echo "Error: binary not found in archive" >&2
    exit 1
  fi

  mv "$tmp_dir/narra" "$BINARY"
  chmod +x "$BINARY"
  echo "Installed narra v${NARRA_VERSION} to ${BINARY}" >&2
}

# --- Version check ---

needs_download() {
  if [ ! -f "$BINARY" ]; then
    return 0
  fi

  local current
  current="$("$BINARY" --version 2>/dev/null | awk '{print $2}')" || return 0

  if [ "$current" != "$NARRA_VERSION" ]; then
    echo "Version mismatch: have ${current}, want ${NARRA_VERSION}" >&2
    return 0
  fi

  return 1
}

# --- Main ---

if needs_download; then
  target="$(detect_target)"
  download_binary "$target"
fi

# the embedding model will be fetched in this path
cd "$SCRIPT_DIR/.."
exec "$BINARY" "$@"
