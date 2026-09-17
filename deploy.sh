#!/usr/bin/env bash

echo "🚀 Начинаем развертывание демо-сайта..."

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="${APP_DIR}"
SERVICE_NAME="catty-reminders-app.service"

echo "📁 Копируем файлы..."

rsync -a --delete \
  --exclude '.git' \
  --exclude '.venv' \
  --exclude 'venv' \
  --exclude '__pycache__' \
  --exclude '*.pyc' \
  "$SOURCE_DIR"/ "$APP_DIR"/

echo "🔄 Перезапускаем сервис..."
sudo systemctl restart "$SERVICE_NAME"

echo "✅ Деплой завершён"