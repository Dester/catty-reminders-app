#!/usr/bin/env bash

echo "🚀 Начинаем развертывание демо-сайта..."

uvicorn app.main:app --reload --host 0.0.0.0 --port 8181