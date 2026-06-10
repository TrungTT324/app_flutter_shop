#!/usr/bin/env bash
set -euo pipefail

REPO="TrungTT324/app_flutter_shop"
REPO_DIR="/Users/trungtruong/xsofts_prj/agents/github/app_flutter_shop"
LABEL="claude"                       # chỉ xử lý issue có label này
STATE_FILE="$HOME/.claude-watcher-seen"
touch "$STATE_FILE"

cd "$REPO_DIR"

# Lấy issue đang mở có label, dạng JSON
gh issue list --repo "$REPO" --label "$LABEL" --state open \
  --json number,title,body | jq -c '.[]' | while read -r issue; do

  num=$(echo "$issue" | jq -r '.number')
  title=$(echo "$issue" | jq -r '.title')
  body=$(echo "$issue" | jq -r '.body')

  # Bỏ qua nếu đã xử lý
  if grep -q "^${num}$" "$STATE_FILE"; then
    continue
  fi

  echo ">> Đang xử lý issue #$num: $title"

  # Tạo branch mới
  git checkout main && git pull
  git checkout -b "issue-$num"

  # Gọi Claude Code headless
  claude -p "Issue #$num: $title

$body

Thực hiện toàn bộ task được mô tả ở trên. Chỉ chỉnh sửa code, không commit." \
    --allowedTools Edit Write Read Bash \
    --permission-mode acceptEdits

  # Commit + push + tạo PR
  git add -A
  git commit -m "Resolve issue #$num: $title"
  git push -u origin "issue-$num"
  gh pr create --repo "$REPO" --fill --base main \
    --body "Tự động xử lý bởi Claude Code. Closes #$num"

  # Đánh dấu đã xử lý
  echo "$num" >> "$STATE_FILE"
  git checkout main
done