#!/usr/bin/env bash

echo "🚀 Начинаем развертывание демо-сайта..."

APP_DIR="/home/dester/Desktop/catty-reminders-app"
APP_SERVICE="catty-reminders-app.service"
ENV_FILE="/etc/catty-reminders-app.env"
DEPLOY_REF="${DEPLOY_REF:-$(git rev-parse --short HEAD)}"

# Копируем файлы
echo "📁 Деплой $DEPLOY_REF в $APP_DIR"
sudo rsync -a --delete \
  --exclude '.git' \
  --exclude '.venv' \
  --exclude '__pycache__' \
  --exclude '*.pyc' \
  ./ "$APP_DIR"/

echo "🔄 Перезапускаем сервис..."
sudo systemctl restart "$APP_SERVICE"

echo "✅ Деплой завершён: $DEPLOY_REF"