#!/bin/bash
set -e

echo "🚀 Initializing Claude Code Boilerplate Template"
echo ""

# Prompt for configuration
read -p "Repository name (e.g., my-project): " REPO_NAME
read -p "GitHub username (e.g., your-username): " GITHUB_USER
read -p "Repository path (e.g., /home/user/dev/my-project or $(pwd)): " REPO_PATH

# Use current directory if no path provided
if [ -z "$REPO_PATH" ]; then
  REPO_PATH=$(pwd)
fi

# Replace placeholders
echo "📝 Replacing template placeholders..."
find . -type f \( -name "*.md" -o -name "*.sh" -o -name "*.json" \) \
  -not -path "*/.git/*" \
  -not -path "*/scripts/*" \
  -exec sed -i "s/{{REPO_NAME}}/$REPO_NAME/g" {} \; \
  -exec sed -i "s/{{GITHUB_USER}}/$GITHUB_USER/g" {} \; \
  -exec sed -i "s|{{REPO_PATH}}|$REPO_PATH|g" {} \;

# Initialize thoughts submodule
echo "📚 Setting up thoughts submodule..."
read -p "Do you want to create a thoughts repository? (y/n): " CREATE_THOUGHTS

if [ "$CREATE_THOUGHTS" = "y" ]; then
  echo "Please create an empty GitHub repository named: ${REPO_NAME}-thoughts"
  echo "Then press Enter to continue..."
  read

  git submodule add "https://github.com/${GITHUB_USER}/${REPO_NAME}-thoughts.git" thoughts
  cd thoughts
  mkdir -p shared/{research,plans,tickets}
  git add .
  git commit -m "Initialize thoughts structure"
  git push
  cd ..
fi

# Update git config
echo "🔧 Updating git configuration..."
git add .
git commit -m "Initialize from claude-code-boilerplate template"

echo ""
echo "✅ Template initialization complete!"
echo ""
echo "Next steps:"
echo "1. Review and configure .mcp.example.json (copy to claude.json)"
echo "2. Install MCP servers: kit-dev, Ref, Linear (optional)"
echo "3. Review .claude/settings.json for team configuration"
echo "4. Start using: claude"
echo ""
echo "Documentation: See README.md for full setup guide"
