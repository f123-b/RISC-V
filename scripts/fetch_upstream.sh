#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="${ROOT}/.deps/core-v-verif"
REV="f3b1f971e0e6b94deae46d279cc50ca390785369"
mkdir -p "${ROOT}/.deps"
if [[ ! -d "${DEST}/.git" ]]; then
  git clone https://github.com/openhwgroup/core-v-verif.git "${DEST}"
fi
git -C "${DEST}" fetch --depth 1 origin "${REV}"
git -C "${DEST}" checkout --detach "${REV}"
echo "core-v-verif pinned at $(git -C "${DEST}" rev-parse HEAD)"
