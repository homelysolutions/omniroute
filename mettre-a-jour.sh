#!/usr/bin/env bash
# Update OmniRoute to a given version, e.g. ./mettre-a-jour.sh 3.8.54
# Versions: https://hub.docker.com/r/diegosouzapw/omniroute/tags (use a plain number, never "next").
set -euo pipefail
cd "$(dirname "$0")"
version="${1:?Indique la version, par exemple : ./mettre-a-jour.sh 3.8.54}"
[[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "Version invalide : $version"; exit 1; }
sed -i '' -E "s/OMNIROUTE_VERSION:-[0-9.]+/OMNIROUTE_VERSION:-$version/" docker-compose.yml
docker compose pull
docker compose up -d
echo "OmniRoute est passé en version $version. Pense à enregistrer ce changement (git commit)."
