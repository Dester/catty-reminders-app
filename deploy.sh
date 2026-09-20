#!/usr/bin/env bash

set -e

DEPLOY_PORT="${DEPLOY_PORT:-22}"
CONTAINER_NAME="catty-reminders-app"
PORT="8181"
IMAGE="${IMAGE_NAME,,}:$RELEASE_HASH"

echo "Deploying to $DEPLOY_HOST:$DEPLOY_PORT"
echo "Image: $IMAGE"
echo "Release: $RELEASE_HASH"

SSH_OPTIONS="-p $DEPLOY_PORT -o StrictHostKeyChecking=no"

ssh $SSH_OPTIONS "$DEPLOY_USER@$DEPLOY_HOST" << EOF
    set -e

    echo "$DOCKER_TOKEN" | docker login ghcr.io -u "$GITHUB_ACTOR" --password-stdin

    docker pull "$IMAGE"

    docker stop "$CONTAINER_NAME" 2>/dev/null || true
    docker rm   "$CONTAINER_NAME" 2>/dev/null || true

    docker run -d \\
        --name "$CONTAINER_NAME" \\
        --restart unless-stopped \\
        -p $PORT:$PORT \\
        -e DEPLOY_REF="$RELEASE_HASH" \\
        "$IMAGE"

    sleep 5

    if docker ps --filter "name=$CONTAINER_NAME" --filter "status=running" | grep -q "$CONTAINER_NAME"; then
        echo "Deployment completed successfully"
    else
        echo "ERROR: container failed to start"
        docker logs "$CONTAINER_NAME" || true
        exit 1
    fi
EOF