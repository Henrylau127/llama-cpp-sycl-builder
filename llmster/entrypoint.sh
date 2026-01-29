#!/usr/bin/env bash
set -euo pipefail

# Ensure lms is discoverable in non-interactive shells
export PATH="/home/lm/.lmstudio/bin:${PATH}"

# If LM Studio home was redirected by ~/.lmstudio-home-pointer, honor it. [attached_file:1]
if [ -f /home/lm/.lmstudio-home-pointer ]; then
  LMS_HOME="$(cat /home/lm/.lmstudio-home-pointer)"
  export PATH="${LMS_HOME}/bin:${PATH}"
fi

# Hard fail early with a clearer error
command -v lms >/dev/null 2>&1 || { echo "lms not found on PATH: $PATH"; exit 127; }

_term() {
  lms server stop >/dev/null 2>&1 || true
  lms daemon down >/dev/null 2>&1 || true
  exit 0
}
trap _term TERM INT

lms daemon up
lms server start

while true; do
  lms server status >/dev/null 2>&1 || exit 1
  sleep 2
done
