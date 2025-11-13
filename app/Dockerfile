# Étape 1 : Choix de l’image de base
FROM nginx:alpine

# Étape 2 : Copier ton application
COPY ./app /usr/share/nginx/html

# Étape 3 : Exposer le port
EXPOSE 80

# Étape 4 : Commande de démarrage
CMD ["nginx", "-g", "daemon off;"]
