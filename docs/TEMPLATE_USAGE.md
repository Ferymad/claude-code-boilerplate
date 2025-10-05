# Template Usage Guide

## Creating a New Project

### Step 1: Create Repository from Template

**Via GitHub UI:**
1. Navigate to https://github.com/Ferymad/claude-code-boilerplate
2. Click "Use this template" → "Create a new repository"
3. Choose name, visibility, and description
4. Click "Create repository"

**Via GitHub CLI:**
```bash
gh repo create my-awesome-project --template Ferymad/claude-code-boilerplate
```

### Step 2: Clone and Initialize

```bash
# Clone your new repository
git clone https://github.com/your-username/my-awesome-project
cd my-awesome-project

# Run initialization script
./scripts/init-template.sh

# Follow prompts to configure:
# - Repository name
# - GitHub username
# - Repository path
```

### Step 3: Set Up MCP Servers

```bash
# Run setup script
./scripts/setup.sh

# Edit claude.json to add:
# - MCP server configurations
# - API keys (Linear, etc.)
# - Custom server paths
```

### Step 4: Create Thoughts Repository (Optional)

```bash
# Create empty repository on GitHub: my-awesome-project-thoughts

# Add as submodule
git submodule add https://github.com/your-username/my-awesome-project-thoughts thoughts

# Initialize structure
cd thoughts
mkdir -p shared/{research,plans,tickets}
git add .
git commit -m "Initialize thoughts structure"
git push
cd ..
```

### Step 5: Customize for Your Project

**Review and customize:**
- `.claude/agents/` - Keep relevant agents, remove others
- `.claude/commands/` - Adapt commands to your workflow
- `.claude/settings.json` - Configure team settings
- `README.md` - Update with project-specific information
- `CLAUDE.md` - Add project-specific MCP guidelines

### Step 6: Start Development

```bash
claude
```

## Customization Examples

### Example 1: Remove Linear Integration

If not using Linear:
```bash
# Remove Linear MCP from claude.json
# Remove Linear agents
rm .claude/agents/linear-ticket-reader.md
rm .claude/agents/linear-searcher.md

# Remove Linear commands
rm .claude/commands/linear.md
rm .claude/commands/ralph_plan.md
```

### Example 2: Add Custom MCP Server

```json
// In claude.json
{
  "mcpServers": {
    "custom-server": {
      "command": "node",
      "args": ["/path/to/custom-mcp-server/index.js"]
    }
  }
}
```

### Example 3: Customize Agent Prompts

Edit `.claude/agents/codebase-analyzer.md`:
```markdown
# Add project-specific instructions
When analyzing {{REPO_NAME}} codebase:
- Follow our team's coding standards in docs/STANDARDS.md
- Pay special attention to {domain-specific patterns}
- Reference our architecture docs in docs/architecture/

[... rest of agent prompt ...]
```

## Maintenance

### Syncing Updates from Template

When the template receives updates:

```bash
# Add template as remote
git remote add template https://github.com/Ferymad/claude-code-boilerplate

# Fetch template changes
git fetch template

# Review changes
git diff template/main

# Merge selectively (review conflicts carefully)
git merge template/main --no-commit

# Resolve conflicts, keeping your customizations
# Commit the merge
git commit -m "Merge template updates"
```

### Contributing Back to Template

If you discover improvements that benefit all users:
1. Test the change in your project
2. Genericize the change (replace specific values with placeholders)
3. Submit PR to claude-code-boilerplate
4. See [CONTRIBUTING.md](../CONTRIBUTING.md)

## Troubleshooting

### Template Initialization Failed

**Issue**: Placeholders not replaced
**Solution**: Run `./scripts/init-template.sh` manually

### MCP Servers Not Working

**Issue**: MCP servers not connecting
**Solution**:
1. Check `claude.json` configuration
2. Verify MCP server installations
3. Check server logs in ~/.claude/logs/

### Thoughts Submodule Issues

**Issue**: Thoughts submodule not initialized
**Solution**:
```bash
git submodule update --init --recursive
```

## FAQ

**Q: Can I use this template for private repositories?**
A: Yes, create as private repository when using template.

**Q: Do I need all MCP servers?**
A: No, kit-dev and Ref are recommended. Linear is optional.

**Q: Can I use without thoughts system?**
A: Yes, remove thoughts/ directory and related command references.

**Q: How do I update my project when template improves?**
A: See "Syncing Updates from Template" section above.
