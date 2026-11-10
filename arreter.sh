#!/usr/bin/env bash
# Stop OmniRoute. Settings and connected providers are kept.
set -euo pipefail
cd "$(dirname "$0")"
docker compose down
echo "OmniRoute est arrêté. Tes réglages sont conservés."
