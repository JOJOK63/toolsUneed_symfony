Write-Host "Demarrage des conteneurs..." -ForegroundColor Green
docker compose up -d --build

Write-Host "Attente de la base de donnees..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

Write-Host "Installation des dependances PHP..." -ForegroundColor Green
docker compose exec app composer install --no-interaction --optimize-autoloader

Write-Host "Installation de Stimulus..." -ForegroundColor Green
docker compose exec app php bin/console importmap:install
docker compose exec app php bin/console importmap:require stimulus

Write-Host "Setup termine !" -ForegroundColor Green
Write-Host "Application disponible sur http://localhost:8000" -ForegroundColor Cyan