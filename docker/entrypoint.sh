#!/bin/bash
set -e

HOST_UID=${HOST_UID:-1000}
HOST_GID=${HOST_GID:-1000}

echo "🔧 Adaptation de www-data → UID=$HOST_UID / GID=$HOST_GID"

# Adapter www-data au bon UID/GID de l'hôte
groupmod -g "$HOST_GID" www-data 2>/dev/null || true
usermod -u "$HOST_UID" www-data 2>/dev/null || true

# Corriger les permissions du dossier var/
chown -R "$HOST_UID:$HOST_GID" /var/www/html/var

# Lancer Apache en tant que www-data (comportement normal)
exec apache2-foreground
