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

# Install into the mounted volume if missing
if ! command -v lms >/dev/null 2>&1; then
  LMS_NO_MODIFY_PATH=1 sh -c "curl -fsSL https://lmstudio.ai/install.sh | sh"
  export PATH="/home/lm/.lmstudio/bin:${PATH}"
fi

lms daemon up
lms server start

# Keep PID 1 alive without triggering “wake up” behavior repeatedly
while true; do sleep 3600; done
