#!/usr/bin/env bash
# Start Claude Code with OmniRoute (free OpenRouter models) instead of Anthropic.
# Your normal "claude" command is not changed: only this launcher goes through OmniRoute.
# Usage: go to a PERSONAL project folder, then run this script. Extra arguments go to claude.
# Other model: OMNIROUTE_MODEL=openrouter/google/gemma-4-31b-it:free ./claude-omniroute.sh
set -euo pipefail

# Client projects must never go through free providers (they may read and keep the data).
case "$PWD" in
  *[Ll]oomy*|*[Ss]uarato*|*[Mm]enuiserie*|*[Dd]ialpine*|*[Tt]alk[-\ ][Ff]low*)
    echo "Stop : ce dossier ressemble à un projet client ($PWD)."
    echo "Les projets clients ne passent jamais par OmniRoute. Utilise ta commande claude habituelle."
    exit 1 ;;
esac

if ! curl -fsS -m 3 -o /dev/null http://localhost:20128/api/health/ping; then
  echo "OmniRoute ne répond pas. Lance d'abord : ~/Dropbox/Claude/omniroute/demarrer.sh"
  exit 1
fi

if ! KEY=$(security find-generic-password -s omniroute -a dev-mac -w 2>/dev/null); then
  echo "Clé OmniRoute introuvable. Enregistre-la d'abord : ~/Dropbox/Claude/omniroute/enregistrer-cle.sh"
  exit 1
fi

MODEL="${OMNIROUTE_MODEL:-openrouter/nvidia/nemotron-3.5-lightning:free}"
echo "Claude Code via OmniRoute, modèle : $MODEL"

export ANTHROPIC_BASE_URL="http://localhost:20128"
export ANTHROPIC_AUTH_TOKEN="$KEY"
export ANTHROPIC_API_KEY=""
export ANTHROPIC_MODEL="$MODEL"
export ANTHROPIC_DEFAULT_OPUS_MODEL="$MODEL"
export ANTHROPIC_DEFAULT_SONNET_MODEL="$MODEL"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="$MODEL"
export CLAUDE_CODE_SUBAGENT_MODEL="$MODEL"
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
exec claude "$@"
