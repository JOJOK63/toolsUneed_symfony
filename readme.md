# 🛠️ Projet Symfony + Docker

Symfony 7 · PHP 8.4 · Apache · MySQL 8 · Stimulus · Tailwind CSS

---

## Prérequis

- [Docker](https://www.docker.com/get-started) ≥ 24.x
- Docker Compose
- Git

---

## Installation (première fois)

### Sur Linux/Mac :
```bash
# 1. Cloner le projet
git clone <URL_DU_REPO>
cd <NOM_DU_PROJET>

# 2. Lancer le setup (build + dépendances + assets) 
chmod +x docker-setup.sh
./docker-setup.sh
```

### Sur Windows :
```powershell
# 1. Cloner le projet
git clone <URL_DU_REPO>
cd <NOM_DU_PROJET>

# 2. Lancer le setup
.\docker-setup.ps1
```

➡️ L'application est disponible sur [http://localhost:8000](http://localhost:8000)

> Les scripts de setup sont à lancer **une seule fois** par machine. Ils build l'image, installent les dépendances PHP, npm et les assets JS.

---

## Configuration Tailwind CSS (si pas déjà fait)
```bash
# Entrer dans le conteneur
docker compose exec app bash

# Installer Tailwind
npm install -D tailwindcss
npx tailwindcss init

# Lancer le build en mode watch (développement)
npx tailwindcss -i ./assets/styles/app.css -o ./public/build/app.css --watch
```

### Structure des fichiers CSS

Créer `assets/styles/app.css` :
```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

Configurer `tailwind.config.js` :
```javascript
module.exports = {
  content: [
    "./templates/**/*.html.twig",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

Dans `templates/base.html.twig` :
```twig
<link href="{{ asset('build/app.css') }}" rel="stylesheet">
```

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

# Build Tailwind en mode watch (dans un autre terminal)
docker compose exec app npx tailwindcss -i ./assets/styles/app.css -o ./public/build/app.css --watch
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

## Commandes npm/Tailwind
```bash
# Installer un package npm
docker compose exec app npm install <package>

# Installer un package npm en dev
docker compose exec app npm install -D <package>

# Build Tailwind (production)
docker compose exec app npx tailwindcss -i ./assets/styles/app.css -o ./public/build/app.css --minify

# Build Tailwind (développement en continu)
docker compose exec app npx tailwindcss -i ./assets/styles/app.css -o ./public/build/app.css --watch
```

---

## Base de données

| Paramètre | Valeur    |
| --------- | --------- |
| Host      | localhost |
| Port      | 3307      |
| User      | root      |
| Password  | root      |
| Database  | symfony   |

---

## Repartir de zéro
```bash
docker compose down -v # supprime les volumes
./docker-setup.sh # réinstalle tout (Linux/Mac)
```
```powershell
docker compose down -v # supprime les volumes
.\docker-setup.ps1 # réinstalle tout (Windows)
```
