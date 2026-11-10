# OmniRoute (local Mac setup)

Deployment kit for OmniRoute on Jérôme's Mac. Jérôme is a beginner: answer in French, use "tu",
explain each command in one simple sentence and say what he should see on screen.

- Docker Compose only (`docker-compose.yml`), bound to 127.0.0.1. Never expose port 20128 to the network.
- Image version pinned in `docker-compose.yml`; change it only through `mettre-a-jour.sh`, never to `latest` or `next`.
- No secret in this repository: provider keys and the OmniRoute key live in the OmniRoute dashboard.
- Never connect a Claude subscription, web-cookie or "stealth" provider, nor providers marked `tos: avoid`. Real API keys only.
- Never route client data or client project code through OmniRoute.
