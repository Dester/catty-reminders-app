#!/usr/bin/env bash

# Скрипт настройки окружения для DevOps демонстрации
# Устанавливает все необходимые компоненты для запуска demo-website

set -e

echo "🚀 Настройка окружения для DevOps демонстрации..."

# Проверяем что запущено с правами root
if [[ $EUID -ne 0 ]]; then
   echo "❌ Этот скрипт должен запускаться с правами root (sudo)"
   exit 1
fi

# Обновляем список пакетов
echo "📦 Обновляем список пакетов..."
apt update

# Устанавливаем nginx
echo "🌐 Устанавливаем nginx..."
apt install -y nginx

# Проверяем что nginx установлен
if ! command -v nginx &> /dev/null; then
    echo "❌ Ошибка: nginx не установлен"
    exit 1
fi

echo "✅ nginx установлен: $(nginx -v 2>&1)"

# Запускаем и включаем nginx
echo "🔧 Настраиваем nginx..."
systemctl enable nginx
systemctl start nginx

# Проверяем статус nginx
if systemctl is-active --quiet nginx; then
    echo "✅ nginx запущен и работает"
else
    echo "❌ Ошибка: nginx не запущен"
    exit 1
fi

# Создаем директорию для логов (если нужно)
mkdir -p /var/log/nginx
chown www-data:www-data /var/log/nginx

# Проверяем что порт 80 доступен
if netstat -tuln | grep -q ":80 "; then
    echo "✅ nginx слушает на порту 80"
else
    echo "⚠️  nginx может не слушать на порту 80"
fi

echo ""
echo "🎉 Окружение настроено успешно!"
echo ""
echo "📋 Что установлено:"
echo "   ✅ nginx - веб-сервер"
echo ""
echo "🔍 Полезные команды:"
echo "   sudo systemctl status nginx     # Проверить статус nginx"
echo "   sudo systemctl restart nginx   # Перезапустить nginx"
echo "   sudo nginx -t                  # Проверить конфигурацию nginx"
echo "   curl http://localhost          # Проверить что nginx отвечает"
echo ""
echo "🚀 Теперь можно запускать: ./deploy.sh"