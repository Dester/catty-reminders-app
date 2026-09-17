#!/usr/bin/env bash

STATE=$1
DESCRIPTION=$2

REPO_DIR="/home/dester/Desktop/catty-reminders-app"
OWNER="Dester"
REPO="catty-reminders-app"

cd "$REPO_DIR"

SHA=$(git rev-parse HEAD)

curl -X POST \
-H "Authorization: Bearer $GITHUB_TOKEN" \
-H "Accept: application/vnd.github+json" \
https://api.github.com/repos/$OWNER/$REPO/statuses/$SHA \
-d "{
    \"state\":\"$STATE\",
    \"context\":\"webhook-deploy\",
    \"description\":\"$DESCRIPTION\",
    \"target_url\":\"http://app.nosov.course.prafdin.space\"
}"