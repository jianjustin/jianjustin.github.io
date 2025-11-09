#!/bin/bash
# deploy_advanced.sh - 增强版部署脚本

set -e

# 配置变量
WORK_DIR="/home/ubuntu/workspaces/jianjustin.github.io"
LOG_FILE="/tmp/hugo_deploy.log"
BACKUP_DIR="/www/backup_$(date +%Y%m%d_%H%M%S)"

echo "=== Hugo 网站自动化部署 ==="
echo "时间: $(date)"
echo "工作目录: $WORK_DIR"

cd "$WORK_DIR"

# 记录日志
exec > >(tee -a "$LOG_FILE") 2>&1

# 函数：错误处理
error_handler() {
    echo "❌ 部署过程中发生错误！"
    echo "请检查日志文件: $LOG_FILE"
    exit 1
}

trap error_handler ERR

# 步骤1: Git 操作
echo "步骤1: 同步 Git 仓库..."
echo "当前分支: $(git branch --show-current)"
echo "最近提交: $(git log -1 --oneline)"

git fetch --all
git reset --hard HEAD
git pull origin main

echo "✅ Git 同步完成"
echo "更新后提交: $(git log -1 --oneline)"

# 步骤2: 备份现有网站
echo "步骤2: 备份现有网站..."

# 删除旧备份 (保留最近3个备份)
echo "清理旧备份..."
OLD_BACKUPS=$(sudo find /www/ -name "backup_*" -type d 2>/dev/null | sort -r | tail -n +4)
if [ -n "$OLD_BACKUPS" ]; then
    echo "删除旧备份目录:"
    echo "$OLD_BACKUPS" | while read backup_dir; do
        echo "  - $backup_dir"
        sudo rm -rf "$backup_dir"
    done
    echo "✅ 旧备份清理完成"
else
    echo "ℹ️  没有需要删除的旧备份"
fi

if [ -d "/www/data" ]; then
    sudo mkdir -p "$BACKUP_DIR"
    sudo cp -r /www/data/* "$BACKUP_DIR/" 2>/dev/null || true
    echo "✅ 网站已备份到: $BACKUP_DIR"
else
    echo "⚠️  目标目录 /www/data 不存在，跳过备份"
fi

# 步骤3: Hugo 构建
echo "步骤3: 构建 Hugo 网站..."
echo "Hugo 版本: $(hugo version)"

# 清理旧构建
rm -rf public/

# 构建网站
hugo --minify --cleanDestinationDir

if [ -f "public/index.html" ]; then
    echo "✅ Hugo 构建成功"
    echo "生成文件:"
    echo "  - 首页: public/index.html"
    echo "  - 总文件数: $(find public -type f | wc -l)"
    echo "  - 目录大小: $(du -sh public | cut -f1)"
else
    echo "❌ 错误: index.html 未生成"
    exit 1
fi

# 步骤4: 部署到服务器
echo "步骤4: 部署到 Web 服务器..."
sudo rsync -av --delete --progress public/ /www/data/

echo "✅ 文件同步完成"

# 步骤5: 设置权限
echo "步骤5: 设置文件权限..."
sudo chown -R www-data:www-data /www/data/
sudo find /www/data/ -type f -exec chmod 644 {} \;
sudo find /www/data/ -type d -exec chmod 755 {} \;

echo "✅ 权限设置完成"

# 部署完成
echo ""
echo "🎉 部署成功完成！"
echo "📊 部署统计:"
echo "   - 源提交: $(git log -1 --oneline)"
echo "   - 生成文件: $(find public -type f | wc -l) 个"
echo "   - 备份位置: $BACKUP_DIR"
echo "   - 日志文件: $LOG_FILE"
echo "   - 完成时间: $(date)"