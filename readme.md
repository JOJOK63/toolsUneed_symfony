# 🛠️ Projet Symfony + Docker

Symfony 7 · PHP 8.4 · Apache · MySQL 8 · Stimulus

---

## Prérequis

- [Docker](https://www.docker.com/get-started) ≥ 24.x
- Docker Compose
- Git

---

## Installation (première fois)

```bash
# 1. Cloner le projet
git clone <URL_DU_REPO>
cd <NOM_DU_PROJET>

# 2. Lancer le setup (build + dépendances + assets)
chmod +x docker-setup.sh
./docker-setup.sh
```

➡️ L'application est disponible sur [http://localhost:8000](http://localhost:8000)

> `docker-setup.sh` est à lancer **une seule fois** par machine. Il build l'image, installe les dépendances PHP et les assets JS.

---

## Au quotidien

```bash
# Démarrer
docker compose up -d

# Arrêter
docker compose down

# Logs en temps réel
docker compose logs -f app

# Terminal dans le conteneur
docker compose exec app bash
```

---

## Commandes Symfony

```bash
# Vider le cache
docker compose exec app php bin/console cache:clear

# Créer une migration
docker compose exec app php bin/console make:migration

# Lancer les migrations
docker compose exec app php bin/console doctrine:migrations:migrate

# Installer une lib PHP
docker compose exec app composer require <package>

# Installer une lib JS
docker compose exec app php bin/console importmap:require <package>
```

---

## Base de données

| Paramètre | Valeur     |
|-----------|------------|
| Host      | localhost  |
| Port      | 3307       |
| User      | root       |
| Password  | root       |
| Database  | symfony    |

---

## Repartir de zéro

```bash
docker compose down -v          # supprime les volumes
./docker-setup.sh               # réinstalle tout
```
