# 📝 Pipeline CI/CD – Documentation et Checklist

## 1. Objectif

Cette pipeline CI/CD automatisée permet de :

* Exécuter les tests de l’application (`check_app.sh`).
* Construire une image Docker à partir du dossier `app/`.
* Pousser l’image Docker sur Docker Hub (ou GHCR).
* Envoyer une notification Google Chat en cas de succès ou d’échec.

---

## 2. Prérequis

* Compte GitHub avec un dépôt configuré.
* Docker installé localement pour tests.
* Secrets GitHub configurés :

  * `DOCKER_USERNAME` → Nom d’utilisateur Docker Hub.
  * `DOCKER_PASSWORD` → Mot de passe Docker Hub.
  * `GOOGLE_CHAT_WEBHOOK_URL` → URL du webhook Google Chat (Incoming Webhook).

---

## 3. Checklist de validation

1. **Tests automatiques**

   * Tous les tests doivent passer via `app/check_app.sh`.
   * Vérifier que le workflow échoue si un test échoue.

2. **Image Docker**

   * Construire localement avec :

     ```bash
     docker build -t myapp:dev ./app
     docker run -p 8080:80 myapp:dev
     ```
   * Vérifier que l’application fonctionne localement.

3. **Push Docker**

   * Vérifier que l’image est bien poussée sur Docker Hub / GHCR :

     ```bash
     docker push <DOCKER_USERNAME>/myapp:dev
     ```
   * Utilisation correcte des tags pour différencier `dev` (branche main) et `prod` (tag Git).

4. **Notification Google Chat**

   * Vérifier que la notification est envoyée à chaque exécution.
   * Tester avec un message simple si la notification échoue (`curl` direct).

5. **Sécurité des secrets**

   * Aucun secret ou mot de passe en clair dans le dépôt ou le workflow.
   * Tous les secrets doivent passer par GitHub Actions.

6. **Historique des workflows**

   * Consulter l’onglet **Actions** sur GitHub pour suivre l’exécution.
   * Vérifier que les jobs se déclenchent correctement sur push et tags.

7. **Documentation interne**

   * Indiquer la procédure pour ajouter/modifier les secrets.
   * Indiquer comment tester la pipeline localement.
   * Ajouter des informations sur les erreurs fréquentes (Docker, Google Chat).

---

## 4. Commandes utiles

```bash
# Lancer les tests localement
cd app
chmod +x check_app.sh
./check_app.sh

# Construire l'image Docker
docker build -t myapp:dev ./app

# Lancer le conteneur
docker run -p 8080:80 myapp:dev

# Pousser l'image Docker
docker push <DOCKER_USERNAME>/myapp:dev

# Tester la notification Google Chat
curl -X POST -H "Content-Type: application/json" \
  -d '{"text": "Test notification"}' \
  "<GOOGLE_CHAT_WEBHOOK_URL>"
```

---

## 5. Bonnes pratiques

* Toujours tester localement avant de pousser.
* Utiliser des branches pour les tests et tags pour la production.
* Vérifier les logs de GitHub Actions pour diagnostiquer rapidement les échecs.
* Ne jamais exposer de secrets dans le dépôt.

---
