#!/usr/bin/env bash

echo "🚀 Начинаем развертывание демо-сайта..."

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="${APP_DIR}"
echo "📂 Исходная директория: $SOURCE_DIR"
echo "📁 Директория приложения: $APP_DIR"

'''echo "📁 Копируем файлы сайта..."
sudo cp index.html /var/www/demo/

# Копируем конфигурацию nginx
echo "⚙️  Применяем конфигурацию nginx..."
sudo cp nginx.conf /etc/nginx/sites-available/demo-site
sudo ln -sf /etc/nginx/sites-available/demo-site /etc/nginx/sites-enabled/

# Проверяем конфигурацию
echo "🔍 Проверяем конфигурацию nginx..."
sudo nginx -t

if [ $? -eq 0 ]; then
    # Перезапускаем nginx
    echo "🔄 Перезапускаем nginx..."
    sudo systemctl reload nginx
    
    echo "✅ Развертывание завершено успешно!"
else
    echo "❌ Ошибка в конфигурации nginx"
    exit 1
fi'''