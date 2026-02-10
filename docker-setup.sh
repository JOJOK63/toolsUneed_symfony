#!/bin/bash
set -e

# Export pour que docker-compose récupère les vraies valeurs
export HOST_UID=$(id -u)
export HOST_GID=$(id -g)

echo "🔧 UID=$HOST_UID / GID=$HOST_GID détectés"

echo "🔧 Correction des permissions..."
if [[ "$OSTYPE" != "msys" && "$OSTYPE" != "win32" ]]; then
    sudo chown -R $HOST_UID:$HOST_GID .
    sudo chmod -R u+rw .
fi

echo "🚀 Démarrage des conteneurs..."
docker compose up -d --build

echo "⏳ Attente que la base de données soit prête..."
sleep 5

echo "🚀 Installation des dépendances PHP..."
docker compose exec app composer install --no-interaction --optimize-autoloader

echo "🎯 Installation de Stimulus via importmap..."
docker compose exec app php bin/console importmap:install
docker compose exec app php bin/console importmap:require stimulus

echo "✅ Setup terminé !"
