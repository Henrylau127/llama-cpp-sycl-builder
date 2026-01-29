#!/usr/bin/env bash
set -euo pipefail

export HOME=/home/lm
export PATH="/home/lm/.lmstudio/bin:${PATH}"

_term() {
  lms server stop >/dev/null 2>&1 || true
  lms daemon down >/dev/null 2>&1 || true
  exit 0
}
trap _term TERM INT

if ! command -v lms >/dev/null 2>&1; then
  echo "lms not found; installing..."
  LMS_NO_MODIFY_PATH=1 sh -c "curl -fsSL https://lmstudio.ai/install.sh | sh"
  export PATH="/home/lm/.lmstudio/bin:${PATH}"
fi

command -v lms >/dev/null 2>&1 || { echo "lms still not found after install"; exit 127; }

lms daemon up
lms server start

while true; do
  lms server status >/dev/null 2>&1 || exit 1
  sleep 2
done
