# Claude Code Boilerplate

> Production-ready GitHub template for AI-assisted development with Claude Code

This template provides a complete AI-assisted development workflow system featuring:
- **10 specialized MCP-enhanced agents** with graceful degradation
- **20+ workflow automation commands** for common development tasks
- **Git submodule knowledge management** for systematic documentation
- **Self-reporting error visibility** in all agents

Originally adapted from [HumanLayer](https://github.com/humanlayer/humanlayer) workflow patterns. See [ACKNOWLEDGMENTS.md](ACKNOWLEDGMENTS.md) for full attribution.

## Using This Template

### Quick Start

1. **Create repository from template:**
   ```bash
   # On GitHub: Click "Use this template" button
   # Or via CLI:
   gh repo create my-project --template Ferymad/claude-code-boilerplate
   ```

2. **Initialize the template:**
   ```bash
   cd my-project
   ./scripts/init-template.sh
   ```

3. **Complete setup:**
   ```bash
   ./scripts/setup.sh
   ```

4. **Start Claude Code:**
   ```bash
   claude
   ```

### What Gets Customized Automatically

The initialization script replaces these placeholders:
- `{{REPO_NAME}}` → Your repository name
- `{{GITHUB_USER}}` → Your GitHub username
- `{{REPO_PATH}}` → Your local repository path

These are automatically configured in:
- All agent prompts (`.claude/agents/`)
- All command prompts (`.claude/commands/`)
- Documentation (README.md, CLAUDE.md)
- Helper scripts (`hack/`)

### What Needs Manual Customization

After initialization, you should customize:

1. **MCP Server Configuration** (`claude.json`):
   - Add API keys for Linear, if using
   - Configure kit-dev paths
   - Add any additional MCP servers

2. **Team Settings** (`.claude/settings.json`):
   - Update team name
   - Adjust budget controls
   - Configure auto-approved tools

3. **Thoughts Submodule**:
   - Create a separate GitHub repository: `{your-repo}-thoughts`
   - Add as submodule: `git submodule add <url> thoughts`
   - Or use template without thoughts (remove references)

4. **Project-Specific Agents/Commands**:
   - Review `.claude/agents/` - remove unused agents
   - Review `.claude/commands/` - customize for your workflow
   - Add project-specific automation

## Template Structure

```
claude-code-boilerplate/
├── .claude/
│   ├── agents/          # 10 specialized MCP-enhanced agents
│   ├── commands/        # 20+ workflow automation commands
│   └── settings.json    # Team configuration
├── .github/
│   ├── workflows/       # Template init & validation
│   └── ISSUE_TEMPLATE/  # Bug reports & feature requests
├── hack/
│   └── spec_metadata.sh # Documentation generation
├── scripts/
│   ├── init-template.sh # Template initialization
│   └── setup.sh         # Post-init setup
├── CLAUDE.md            # MCP integration guidelines
├── LICENSE              # Apache 2.0 with attribution
├── CONTRIBUTING.md      # Contribution guidelines
└── README.md            # This file
```

## MCP-Enhanced Agents

| Agent | Purpose | MCP Tools |
|-------|---------|-----------|
| **codebase-locator** | Find files and components | Kit MCP AST tools |
| **codebase-analyzer** | Analyze code structure | Kit MCP symbols/deps |
| **codebase-pattern-finder** | Find code patterns | Kit MCP pattern tools |
| **external-doc-researcher** | Research documentation | Ref MCP |
| **mcp-package-researcher** | Deep package research | Kit + Ref MCP |
| **codebase-dependency-tracer** | Trace dependencies | Kit MCP |
| **linear-ticket-reader** | Read Linear tickets | Linear MCP |
| **linear-searcher** | Search Linear tickets | Linear MCP |
| **thoughts-locator** | Find thoughts documents | Grep/Glob |
| **thoughts-analyzer** | Analyze thoughts content | Read |

Agents automatically use MCP tools when available, or gracefully degrade to basic tools if not configured.

## MCP Integration

This template is designed to work seamlessly with:
- **Kit MCP** - Codebase intelligence and AST analysis
- **Ref MCP** - External documentation research
- **Linear MCP** - Ticket management (optional)

See [CLAUDE.md](CLAUDE.md) for detailed MCP integration guidelines.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on improving this template.

## License

See [LICENSE](LICENSE) for licensing information and attributions.

## Acknowledgments

See [ACKNOWLEDGMENTS.md](ACKNOWLEDGMENTS.md) for full attribution of patterns adapted from HumanLayer.
