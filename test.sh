#!/bin/bash

set -e

REPO_DIR="/home/catty-reminders-app"
BRANCH=$1

cd "$REPO_DIR"

git fetch origin
git checkout -f -B "$BRANCH" "origin/$BRANCH"
echo "Pull origin $BRANCH"
git pull origin "$BRANCH"

echo "Running tests"

source .venv/bin/activate
echo "Virtual environment activated"

echo "Starting temporary app for testing"

uvicorn app.main:app --host 127.0.0.1 --port 8181 > /tmp/catty-test.log 2>&1 &
APP_PID=$!

sleep 5

echo "Running pytest"
python3 -m pytest -v
RESULT=$?

echo "Stopping temporary app"
kill "$APP_PID" || true

echo "Tests finished"

exit "$RESULT"