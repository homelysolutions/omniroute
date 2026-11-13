# OmniRoute sur mon Mac

Kit pour faire tourner [OmniRoute](https://github.com/diegosouzapw/OmniRoute) (licence MIT) sur ce Mac.
OmniRoute reçoit les demandes de tes outils d'IA (Claude Code, Cursor…) et les transmet aux
fournisseurs que tu as branchés, en passant à un autre quand l'un est à court de crédits.

Ce dépôt ne contient pas le code d'OmniRoute : il télécharge la version officielle (image Docker)
et la fait tourner, uniquement sur ce Mac (adresse 127.0.0.1).

## Installer (une seule fois)

1. Installe **Docker Desktop** : https://www.docker.com/products/docker-desktop/ et ouvre-le.
2. Dans le Terminal :
   ```bash
   git clone https://github.com/homelysolutions/omniroute ~/omniroute
   ~/omniroute/demarrer.sh
   ```
3. Le navigateur s'ouvre sur http://localhost:20128 : c'est le tableau de bord.

## Mot de passe du tableau de bord (une seule fois)

À travers Docker, l'assistant du navigateur ne peut pas enregistrer le mot de passe
(il affiche « jeton d'amorçage » puis « Erreur interne du serveur »). Fais-le plutôt dans le Terminal :

```bash
~/omniroute/definir-mot-de-passe.sh
```

Tape ton mot de passe deux fois (rien ne s'affiche pendant la frappe, c'est normal), puis connecte-toi sur http://localhost:20128.

## Brancher un fournisseur (obligatoire)

Sans fournisseur, OmniRoute ne fait rien.

1. Crée un compte chez un fournisseur avec offre gratuite ou payante, par exemple OpenRouter,
   Groq ou Mistral, et copie ta **clé d'API**.
2. Tableau de bord → **Providers** → choisis le fournisseur → colle la clé.
3. Tableau de bord → **Endpoints** → copie ta **clé OmniRoute** (garde-la pour toi, ne la mets jamais dans Git).
4. Vérifie dans le Terminal (remplace TA_CLE) :
   ```bash
   curl http://localhost:20128/v1/models -H "Authorization: Bearer TA_CLE"
   ```
   Tu dois voir une liste de modèles.

## Brancher un outil

```
Adresse (Base URL) : http://localhost:20128/v1
Clé (API Key)      : ta clé OmniRoute
Modèle             : auto
```

## Utiliser Claude Code avec OmniRoute (projets perso uniquement)

Ta commande `claude` habituelle ne change pas. Un lanceur à part fait passer Claude Code par OmniRoute
et les modèles gratuits d'OpenRouter.

1. Une seule fois, range ta clé OmniRoute dans le Trousseau du Mac :
   ```bash
   ~/Dropbox/Claude/omniroute/enregistrer-cle.sh
   ```
2. Va dans un dossier de projet **perso**, puis lance :
   ```bash
   ~/Dropbox/Claude/omniroute/claude-omniroute.sh
   ```
   La première ligne affiche le modèle utilisé. Pour en essayer un autre :
   `OMNIROUTE_MODEL=openrouter/google/gemma-4-31b-it:free ~/Dropbox/Claude/omniroute/claude-omniroute.sh`

Le lanceur refuse de démarrer dans un dossier de projet client (Loomy, Suarato, Dialpine, Talk Flow…).
Les modèles gratuits sont plus lents et bien moins forts que Claude : garde `claude` pour le travail client et le travail important.

## Au quotidien

| Je veux… | Commande |
|---|---|
| Démarrer | `~/omniroute/demarrer.sh` |
| Arrêter | `~/omniroute/arreter.sh` |
| Mettre à jour | `~/omniroute/mettre-a-jour.sh 3.8.54` (numéro pris sur https://hub.docker.com/r/diegosouzapw/omniroute/tags) |
| Voir ce qui se passe | `cd ~/omniroute && docker compose logs -f omniroute` |

OmniRoute redémarre tout seul avec Docker Desktop. Tes réglages sont gardés dans Docker (volume `omniroute-data`), pas dans ce dépôt.

## Règles de sécurité

- **Jamais de données clients** ni de code des projets clients (Suarato, Loomy, Dialpine, Talk Flow…) :
  les fournisseurs gratuits peuvent lire et garder ce qu'on leur envoie, souvent hors de Suisse.
- **Ne branche pas ton abonnement Claude** ni aucune connexion « web » ou par cookies : c'est contraire
  aux conditions d'Anthropic et ton compte peut être suspendu. Uniquement de vraies clés d'API.
- Laisse désactivés les fournisseurs marqués « avoid » (conditions d'utilisation à risque).
- Aucune clé dans ce dépôt : elles restent dans le tableau de bord.
