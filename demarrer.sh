#!/usr/bin/env bash
# Start OmniRoute and open its dashboard.
set -euo pipefail
cd "$(dirname "$0")"

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker n'est pas installé. Installe Docker Desktop : https://www.docker.com/products/docker-desktop/"
  exit 1
fi
if ! docker info >/dev/null 2>&1; then
  echo "Docker Desktop n'est pas ouvert. Je le lance, patiente..."
  open -a Docker 2>/dev/null || true
  for _ in $(seq 1 60); do docker info >/dev/null 2>&1 && break; sleep 2; done
  docker info >/dev/null 2>&1 || { echo "Docker ne répond pas. Ouvre Docker Desktop puis relance ce script."; exit 1; }
fi

docker compose up -d
echo "Démarrage d'OmniRoute..."
for _ in $(seq 1 60); do
  curl -fsS -o /dev/null http://localhost:20128 && break
  sleep 2
done
if curl -fsS -o /dev/null http://localhost:20128; then
  echo "OmniRoute tourne : http://localhost:20128"
  open http://localhost:20128 2>/dev/null || true
else
  echo "OmniRoute ne répond pas encore. Regarde les messages avec : docker compose logs omniroute"
  exit 1
fi
