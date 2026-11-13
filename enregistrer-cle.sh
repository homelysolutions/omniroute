#!/usr/bin/env bash
# Store the OmniRoute API key in the macOS Keychain (never in this repository).
# macOS asks for the key itself: it is not shown on screen and not kept in the shell history.
set -euo pipefail

echo "Colle ta clé OmniRoute (celle qui commence par sk-) quand macOS la demande, puis Entrée."
echo "Rien ne s'affiche pendant que tu colles : c'est normal."
security add-generic-password -U -s omniroute -a dev-mac -w
echo "Clé enregistrée dans le Trousseau de ton Mac (nom : omniroute)."
