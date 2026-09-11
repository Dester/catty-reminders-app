#!/usr/bin/env bash

set -e

source .venv/bin/activate

fuser -k 8181/tcp 2>/dev/null || true
sleep 1
nohup uvicorn app.main:app --host 0.0.0.0 --port 8181 &