#!/usr/bin/env bash

echo "🚀 Начинаем развертывание демо-сайта..."

cp -r ./ /home/catty-reminders-app
systemctl restart catty-reminders-app