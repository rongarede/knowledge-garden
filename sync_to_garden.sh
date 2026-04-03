#!/bin/bash
set -e

# 知识花园同步脚本
# 从 Obsidian 库选择性同步到公开仓库

VAULT="/Users/bit/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian"
GARDEN="$HOME/knowledge-garden"

echo "=== 同步知识花园 ==="

# --- 1. Zettelkasten（全量同步） ---
echo "[1/2] 同步 Zettelkasten..."
rsync -av --delete \
  --exclude="_zettel_index.md" \
  --include="*.md" \
  --exclude="*" \
  "$VAULT/300_Resources/Zettelkasten/" \
  "$GARDEN/zettelkasten/"

# --- 2. Articles（三源合并，排除 Task_* 和 MOC 索引） ---
echo "[2/2] 同步 Articles..."

# 清空后重新同步，确保删除的文件也被清理
rm -rf "$GARDEN/articles/"
mkdir -p "$GARDEN/articles/blockchain" "$GARDEN/articles/ai" "$GARDEN/articles/tech"

# 2a. 技术文章 → articles/tech/
rsync -av \
  --include="*.md" \
  --exclude="*" \
  "$VAULT/300_Resources/Res_技术文章/" \
  "$GARDEN/articles/tech/"

# 2b. 区块链 → articles/blockchain/（保留子目录结构，排除 Task_* 和 MOC）
rsync -av \
  --exclude="Task_*" \
  --exclude="_*_moc.md" \
  --exclude="_*_index.md" \
  --include="*/" \
  --include="*.md" \
  --exclude="*" \
  "$VAULT/200_Areas/Area_区块链/" \
  "$GARDEN/articles/blockchain/"

# 2c. AI → articles/ai/（排除 Task_* 和 MOC）
rsync -av \
  --exclude="Task_*" \
  --exclude="_*_moc.md" \
  --exclude="_*_index.md" \
  --include="*.md" \
  --exclude="*" \
  "$VAULT/200_Areas/Area_AI/" \
  "$GARDEN/articles/ai/"

# --- 3. Strip 私有 frontmatter 字段 ---
echo "清理私有字段..."
find "$GARDEN" -name "*.md" -exec sed -i '' \
  -e '/^project:/d' \
  -e '/^deadline:/d' \
  -e '/^priority:/d' \
  {} +

# --- 统计 ---
TOTAL=$(find "$GARDEN" -name "*.md" | wc -l | tr -d ' ')
echo ""
echo "=== 同步完成 ==="
echo "共 $TOTAL 篇笔记已同步到 $GARDEN"
echo ""
echo "下一步："
echo "  cd $GARDEN && git add -A && git commit -m 'sync: update garden' && git push"
