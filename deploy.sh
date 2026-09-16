#!/usr/bin/env bash
echo "🚀 Начинаем развертывание catty-reminders-app..."

BRANCH=$1

APP_DIR="/home/catty-reminders-app"


# 1. Обновляем код
echo "📦 Обновляем код из репозитория..."
cd $APP_DIR
git fetch origin
git checkout $BRANCH
git pull origin $BRANCH

COMMIT_HASH=$(git rev-parse HEAD)
echo "Код коммита: $COMMIT_HASH"
echo "DEPLOY_REF=$COMMIT_HASH" > .env
sudo /usr/bin/systemctl restart catty-reminders-app

echo "✅ Развертывание завершено!"