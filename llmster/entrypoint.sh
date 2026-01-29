#!/usr/bin/env bash
set -euo pipefail

_term() {
  lms server stop >/dev/null 2>&1 || true
  lms daemon down >/dev/null 2>&1 || true
  exit 0
}
trap _term TERM INT

lms daemon up

# Start server once (may return immediately even if server keeps running)
lms server start

# Keep container alive while server is up
while true; do
  # If status fails, exit so container restarts (or stays down) rather than looping start logs.
  lms server status >/dev/null 2>&1 || exit 1
  sleep 2
done
