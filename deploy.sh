#!/usr/bin/env bash

APP_DIR="${APP_DIR:-/home/catty-reminders-app}"
SERVICE="${SERVICE:-catty-reminders-app}"
SRC_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$APP_DIR"

rsync -a --delete \
    --exclude='.git' \
    --exclude='.env' \
    --exclude='reminder_db.json' \
    --exclude='.venv' \
    --exclude='venv' \
    --exclude='__pycache__' \
    --exclude='.pytest_cache' \
    "$SRC_DIR"/ "$APP_DIR"/

sudo systemctl restart "$SERVICE"