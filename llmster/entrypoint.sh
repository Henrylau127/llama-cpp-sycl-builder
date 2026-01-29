#!/usr/bin/env bash
set -euo pipefail

_term() {
  # Best-effort shutdown (docs show `lms server stop`; daemon down is also used) [page:1]
  lms server stop >/dev/null 2>&1 || true
  lms daemon down >/dev/null 2>&1 || true
  exit 0
}
trap _term TERM INT

# Bring up the daemon (docs use `lms daemon up`) [page:1]
lms daemon up

# Start the HTTP server (docs: `lms server start`) [page:1][page:2]
lms server start &
server_pid=$!

wait "$server_pid"
