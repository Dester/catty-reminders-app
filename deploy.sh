#!/usr/bin/env bash

echo "🚀 Начинаем развертывание демо-сайта..."

nohup uvicorn app.main:app --reload --host 0.0.0.0 --port 8181 \
    > /tmp/uvicorn.log 2>&1 &