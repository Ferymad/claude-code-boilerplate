#!/bin/bash
set -e

echo "🛠️  Claude Code Boilerplate Setup"
echo ""

# Check if running in initialized repository
if grep -q "{{REPO_NAME}}" README.md 2>/dev/null; then
  echo "⚠️  Template not yet initialized."
  echo "Please run: ./scripts/init-template.sh first"
  exit 1
fi

# Check dependencies
echo "📦 Checking dependencies..."
command -v claude >/dev/null 2>&1 || {
  echo "❌ Claude Code not installed. Install from: https://docs.claude.com/claude-code"
  exit 1
}

# Setup MCP configuration
echo "🔧 Setting up MCP configuration..."
if [ ! -f "claude.json" ]; then
  if [ -f ".mcp.example.json" ]; then
    cp .mcp.example.json claude.json
    echo "✅ Created claude.json from example"
    echo "⚠️  Please edit claude.json to configure MCP servers"
  else
    echo "❌ Missing .mcp.example.json"
    exit 1
  fi
else
  echo "✅ claude.json already exists"
fi

# Initialize thoughts submodule if needed
if [ -d "thoughts" ]; then
  echo "📚 Initializing thoughts submodule..."
  git submodule update --init --recursive
  echo "✅ Thoughts submodule initialized"
else
  echo "⚠️  No thoughts submodule configured"
  echo "   To add: git submodule add <your-thoughts-repo-url> thoughts"
fi

# Create necessary directories
echo "📁 Creating working directories..."
mkdir -p thoughts/shared/{research,plans,tickets}

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit claude.json to configure MCP servers (kit-dev, Ref, Linear)"
echo "2. Review .claude/settings.json for team configuration"
echo "3. Start Claude Code: claude"
echo ""
echo "For full documentation, see README.md"
