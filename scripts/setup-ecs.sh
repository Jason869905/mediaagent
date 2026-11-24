#!/bin/bash
set -e

echo "=========================================="
echo "  MediaAgent ECS 环境安装脚本"
echo "=========================================="

# 检测系统类型
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "错误：无法检测操作系统类型"
    exit 1
fi

echo ">>> 检测到系统: ${OS}"

# 安装 Git
if ! command -v git &>/dev/null; then
    echo ">>> 安装 Git..."
    if [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
        apt-get update && apt-get install -y git
    else
        yum install -y git
    fi
else
    echo ">>> Git 已安装: $(git --version)"
fi

# 安装 Docker
if ! command -v docker &>/dev/null; then
    echo ">>> 安装 Docker..."
    curl -fsSL https://get.docker.com | sh
    systemctl enable --now docker
else
    echo ">>> Docker 已安装: $(docker --version)"
fi

# 检查 Docker Compose V2
if docker compose version &>/dev/null 2>&1; then
    echo ">>> Docker Compose V2 已安装: $(docker compose version)"
else
    echo ">>> 安装 Docker Compose V2 插件..."
    if [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
        apt-get update && apt-get install -y docker-compose-v2 || apt-get install -y docker-compose-plugin
    else
        yum install -y docker-compose-plugin
    fi
fi

# 再次验证
echo ""
echo "=========================================="
echo "  环境检查结果"
echo "=========================================="
echo "Git:        $(git --version 2>/dev/null || echo '未安装')"
echo "Docker:     $(docker --version 2>/dev/null || echo '未安装')"
echo "Compose:    $(docker compose version 2>/dev/null || echo '未安装')"
echo ""

if docker compose version &>/dev/null 2>&1; then
    echo "✅ 环境已就绪，可以执行部署脚本"
else
    echo "❌ Docker Compose 安装失败，请手动检查"
    exit 1
fi
