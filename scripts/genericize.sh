#!/bin/bash
# Replace all hlyr-reveng references with template placeholders

set -e

REPO_DIR="${1:-.}"

echo "🔧 Genericizing hlyr-reveng references to template placeholders..."

# Replace all variations of references
find "$REPO_DIR" -type f \( -name "*.md" -o -name "*.sh" -o -name "*.json" \) \
  -not -path "*/.git/*" \
  -not -path "*/scripts/genericize.sh" \
  -exec sed -i 's/hlyr-reveng/{{REPO_NAME}}/g' {} \; \
  -exec sed -i 's|/home/selman/dev/hlyr-reveng|{{REPO_PATH}}|g' {} \; \
  -exec sed -i 's|~/dev/hlyr-reveng|{{REPO_PATH}}|g' {} \; \
  -exec sed -i 's|~/wt/hlyr-reveng|~/wt/{{REPO_NAME}}|g' {} \; \
  -exec sed -i 's|Ferymad/hlyr-reveng-thoughts|{{GITHUB_USER}}/{{REPO_NAME}}-thoughts|g' {} \;

echo "✅ Genericization complete. Review changes before committing."
