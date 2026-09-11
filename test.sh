#!/usr/bin/env bash

set -e

echo "🧪 Running tests..."

python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --host 0.0.0.0 --port 8181 &
APP_PID=$!
cleanup() {
    kill  "$APP_PID" 2>/dev/null || true
    wait  "$APP_PID" 2>/dev/null || true
    fuser -k 8181/tcp 2>/dev/null || true
}
trap cleanup EXIT
python3 -m pytest tests/test_unit.py
python3 -m pytest tests/test_api.py