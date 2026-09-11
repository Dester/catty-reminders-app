#!/usr/bin/env bash

set -e

echo "🧪 Running tests..."

python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --host 0.0.0.0 --port 8181 &
APP_PID=$!
trap "kill $APP_PID 2>/dev/null || true" EXIT
python3 -m pytest tests/test_unit.py
python3 -m pytest tests/test_api.py