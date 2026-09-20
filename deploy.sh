#!/usr/bin/env bash

set -e

DEPLOY_PORT=${DEPLOY_PORT:-22}
DEPLOY_DIR="/home/dester/Desktop/catty-reminders-app"

echo "Deploying to $DEPLOY_HOST:$DEPLOY_PORT"
echo "User: $DEPLOY_USER"
echo "Release branch: $RELEASE_BRANCH"

SSH_OPTIONS="-p $DEPLOY_PORT -o StrictHostKeyChecking=no"

ssh $SSH_OPTIONS "$DEPLOY_USER@$DEPLOY_HOST" << EOF
    set -e
    
    cd $DEPLOY_DIR
    
    git fetch origin
    git checkout $RELEASE_HASH
    
    DEPLOY_REF=\$(git rev-parse HEAD)
    echo "DEPLOY_REF=\$DEPLOY_REF" > /etc/catty-reminders-app.env
    echo "Deployed version: \$DEPLOY_REF"
    
    if [ ! -d ".venv" ]; then
        python3 -m venv .venv/
    fi
    
    source .venv/bin/activate
    
    if [ -f "requirements.txt" ]; then
        pip install -r requirements.txt
    fi
    
    sudo systemctl restart catty-reminders-app.service
    
    sleep 4
    
    if sudo systemctl is-active --quiet catty-reminders-app.service; then
        echo "Deployment completed successfully"
    else
        echo "ERROR: Application failed to start"
        exit 1
    fi
EOF