#!/usr/bin/env bash
# Set the OmniRoute dashboard password from inside the container.
# Needed on first install: through Docker port-forwarding the browser is not seen as "local",
# so the onboarding wizard refuses to save the password. Inside the container the call is local.
# The password is read silently and sent through stdin: it never appears on screen or in a file.
set -euo pipefail
cd "$(dirname "$0")"

if ! docker compose ps --status running -q omniroute | grep -q .; then
  echo "OmniRoute n'est pas démarré. Lance d'abord : ./demarrer.sh"
  exit 1
fi

read -r -s -p "Nouveau mot de passe du tableau de bord : " pw1; echo
read -r -s -p "Retape-le pour confirmer : " pw2; echo
if [ -z "$pw1" ] || [ "$pw1" != "$pw2" ]; then
  echo "Les deux mots de passe sont vides ou différents. Rien n'a changé, relance le script."
  exit 1
fi

printf '%s' "$pw1" | docker exec -i omniroute node -e '
let pw = "";
process.stdin.on("data", (c) => (pw += c));
process.stdin.on("end", async () => {
  const r = await fetch("http://127.0.0.1:20128/api/settings/require-login", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ requireLogin: true, password: pw }),
  });
  if (!r.ok) {
    console.error("Échec (" + r.status + ") : " + (await r.text()).slice(0, 200));
    process.exit(1);
  }
  console.log("Mot de passe enregistré. Recharge http://localhost:20128 et connecte-toi avec.");
});
'
