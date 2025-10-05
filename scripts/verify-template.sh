#!/bin/bash
set -e

echo "🔍 Verifying Template Structure..."

# Check required files
required_files=(
  "LICENSE"
  "README.md"
  "CLAUDE.md"
  "CONTRIBUTING.md"
  "CODE_OF_CONDUCT.md"
  "SECURITY.md"
  "ACKNOWLEDGMENTS.md"
  ".gitignore"
  ".mcp.example.json"
  ".claude/settings.json"
  "scripts/init-template.sh"
  "scripts/setup.sh"
  "scripts/verify-template.sh"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "❌ Missing: $file"
    exit 1
  fi
done

echo "✅ All required files present"

# Check required directories
required_dirs=(
  ".claude/agents"
  ".claude/commands"
  ".github/workflows"
  ".github/ISSUE_TEMPLATE"
  "hack"
  "docs"
)

for dir in "${required_dirs[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "❌ Missing: $dir"
    exit 1
  fi
done

echo "✅ All required directories present"

# Verify no hardcoded references (exclude scripts and .github workflows which reference it)
if grep -r "hlyr-reveng" . --exclude-dir=.git --exclude-dir=thoughts --exclude-dir=scripts --exclude-dir=.github 2>/dev/null; then
  echo "❌ Found hardcoded references to hlyr-reveng"
  exit 1
fi

echo "✅ No hardcoded references"

# Verify no sensitive information
sensitive_patterns=(
  "sk-[a-zA-Z0-9]+"  # API keys
  "ghp_[a-zA-Z0-9]+"  # GitHub tokens
)

for pattern in "${sensitive_patterns[@]}"; do
  if grep -riE "$pattern" . --exclude-dir=.git 2>/dev/null | grep -v "example\|template\|placeholder"; then
    echo "❌ Found potential sensitive information: $pattern"
    exit 1
  fi
done

echo "✅ No sensitive information detected"

# Verify scripts are executable
scripts=("scripts/init-template.sh" "scripts/setup.sh" "scripts/verify-template.sh")
for script in "${scripts[@]}"; do
  if [ ! -x "$script" ]; then
    echo "❌ Script not executable: $script"
    exit 1
  fi
done

echo "✅ All scripts executable"

# Count agents and commands
agent_count=$(find .claude/agents -name "*.md" | wc -l)
command_count=$(find .claude/commands -name "*.md" | wc -l)

echo "📊 Template Statistics:"
echo "   - Agents: $agent_count"
echo "   - Commands: $command_count"

if [ "$agent_count" -lt 8 ]; then
  echo "⚠️  Warning: Expected at least 8 agents, found $agent_count"
fi

if [ "$command_count" -lt 15 ]; then
  echo "⚠️  Warning: Expected at least 15 commands, found $command_count"
fi

echo ""
echo "✅ Template verification complete!"
