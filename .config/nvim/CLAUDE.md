# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a LazyVim-based Neovim configuration with custom plugins and settings. The configuration follows the standard LazyVim structure with customizations primarily for Ruby/Rails development.

**Key Architectural Points:**

- **Plugin Management**: Uses lazy.nvim as the plugin manager. Plugins are defined in `lua/plugins/*.lua` files and are automatically imported.
- **Configuration Loading Order**:
  1. `init.lua` bootstraps lazy.nvim
  2. `lua/config/lazy.lua` sets up the plugin system
  3. Core config files (`options.lua`, `keymaps.lua`, `autocmds.lua`) are loaded by LazyVim
  4. Individual plugin configurations in `lua/plugins/` override LazyVim defaults
- **Inactive Plugins**: The `lua/inactive-plugins/` directory contains disabled plugin configurations that are not loaded. These are kept for reference or potential future use.

## Development Environment

This configuration is optimized for:
- Ruby/Rails development (Solargraph, Rubocop LSP servers)
- YAML editing with schema validation (yamlls with schemastore)
- Git operations (Fugitive, Gitsigns)
- AI-assisted coding (Claude Code integration, Avante.nvim)

## Core Configuration Files

- `lua/config/options.lua`: Custom vim options (clipboard disabled, mouse disabled, line numbers off, autoformat disabled)
- `lua/config/keymaps.lua`: Custom keybindings (notably `<C-c>` for clipboard copy, `<Leader>\` for grep, YAML key search)
- `lua/config/lazy.lua`: Plugin manager setup with LazyVim integration

## Important Plugin Configurations

### LSP Configuration (`lua/plugins/lsp-config.lua`)
- **Rubocop**: Configured to run via bundle exec with LSP support
- **Solargraph**: Ruby language server configured to use bundler
- **yamlls**: Extensive YAML schema configuration with schemastore integration
- **Diagnostics**: Virtual text and underline are disabled globally

### Claude Code Integration (`lua/plugins/claude-code-nvim.lua`)
- Terminal window opens at 40% height in bottom right position
- Auto-detects git root and sets CWD accordingly
- File refresh enabled with notifications
- Key bindings: `<C-,>` to toggle, `<leader>cC` for continue, `<leader>cV` for verbose

### Formatting (`lua/plugins/conform-nvim.lua`)
- Manual formatting only (autoformat disabled globally)
- Format with `<leader>m`
- Configured formatters: prettier (PHP, HTML, JS), erb_format (eruby), haml-lint (HAML)

### Treesitter (`lua/plugins/treesitter.lua`)
- Auto-installs: ruby, php, lua, vim, vimdoc, query parsers
- Indentation disabled for YAML and Ruby (known issues)

## Working with This Configuration

**Testing Changes:**
- Restart Neovim to reload configuration: `:qa` then reopen
- Check plugin status: `:Lazy`
- Check LSP status: `:LspInfo`
- Check treesitter status: `:TSUpdate` or `:checkhealth nvim-treesitter`

**LSP Servers:**
- All Ruby LSP servers (Solargraph, Rubocop) expect to run via `bundle exec`
- Ensure you're in a project with a Gemfile for Ruby LSP to work
- YAML LSP uses dynamic schema detection from schemastore

**Adding/Modifying Plugins:**
- Create or edit files in `lua/plugins/` directory
- Plugin files should return a lazy.nvim spec table
- Inactive plugins can be moved to `lua/inactive-plugins/` to disable without deleting

**File Operations:**
- Uses oil.nvim for file browsing (not netrw)
- Use `:Oil` to open file explorer in current directory

**Custom Keybindings:**
- Visual mode `<C-c>`: Copy to system clipboard via pbcopy
- Normal mode `<Leader>\`: Live grep with glob patterns (telescope)
- Normal mode `<Leader>Y`: YAML key search function
- Normal mode `gl`: Open diagnostics float with rounded border
