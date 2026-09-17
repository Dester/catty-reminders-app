#!/usr/bin/env bash

set -e

REPO_DIR="/home/dester/Desktop/catty-reminders-app"
BRANCH=$1

echo "Deploying $BRANCH branch"


cd "$REPO_DIR"
echo "Directory changed to $REPO_DIR"

git fetch origin
git checkout -B "$BRANCH" "origin/$BRANCH"
echo "Pull $BRANCH branch"
git pull origin "$BRANCH"

CLEAN_REF=$(git rev-parse HEAD | tr -d '\r')
echo "DEPLOY_REF=$CLEAN_REF" > /tmp/app.env
echo "DEPLOY_REF=$CLEAN_REF" > /home/dester/Desktop/catty-reminders-app/.env.deploy
chmod 644 /home/dester/Desktop/catty-reminders-app/.env.deploy
echo "Deploy ref: $CLEAN_REF"

source .venv/bin/activate
echo "Virtual environment activated"

echo "Restarting app..."
which systemctl
sudo systemctl restart catty-reminders-app.service
echo "Done"