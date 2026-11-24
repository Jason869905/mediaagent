#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

# 加载 .env
if [ -f .env ]; then
    set -a
    source .env
    set +a
fi

if [ -z "$SWR_REGISTRY" ]; then
    echo "错误：请在 .env 中配置 SWR_REGISTRY"
    exit 1
fi

IMAGE_NAME="${IMAGE_NAME:-mediaagent}"
MEDIA_AGENT_TAG="${MEDIA_AGENT_TAG:-latest}"
FULL_IMAGE="${SWR_REGISTRY}/${IMAGE_NAME}:${MEDIA_AGENT_TAG}"

echo ">>> 拉取镜像: ${FULL_IMAGE}"
docker pull "$FULL_IMAGE"

echo ">>> 重启服务..."
docker compose up -d

echo ">>> 清理旧镜像..."
docker image prune -f

echo ">>> 部署完成"
docker compose ps
