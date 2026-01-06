# LazyVim .NET Development Setup

Complete Neovim configuration for .NET development with Blazor WebAssembly, Entity Framework, Minimal APIs, and MAUI support.

## 🎯 Features

- ✅ Multi-project solution support (.sln files)
- ✅ C# LSP with OmniSharp and full IntelliSense
- ✅ Blazor WebAssembly support with Razor syntax
- ✅ Entity Framework support
- ✅ Minimal API support
- ✅ MAUI development support
- ✅ PostgreSQL database UI (vim-dadbod)
- ✅ LazyGit integration
- ✅ LazyDocker integration
- ✅ Docker Compose support with LSP
- ✅ Auto-install everything (no manual commands)
- ✅ Portable config (git-friendly)

## 📋 Prerequisites

- macOS (M1 Max)
- Homebrew installed

## 📦 Installation

### How This Works

This setup uses a **bootstrapping approach**:
1. You create empty config files with the LazyVim imports
2. On first `nvim` launch, everything installs automatically:
   - `lazy.nvim` (plugin manager) - bootstraps itself
   - `LazyVim` (the base distribution) - installed as a plugin
   - All other plugins - installed by lazy.nvim
   - LSP servers - installed by Mason
   - Treesitter parsers - installed by nvim-treesitter

No manual installation of LazyVim needed! It's all handled by the config.

### Step 1: Install Dependencies

Run the installation script:

```bash
chmod +x install.sh
./install.sh
```

Or manually install:

```bash
# Core tools
brew install neovim git ripgrep fd fzf

# .NET SDK
brew install --cask dotnet-sdk

# Node.js (skip if using nvm - you already have it!)
# brew install node

# Database tools (use your PostgreSQL version)
brew install postgresql@18 libpq
# OR if you already have PostgreSQL 18: skip this

# Git and Docker tools
brew install lazygit lazydocker
brew install --cask docker
brew install docker-compose

# Optional
brew install gh  # GitHub CLI

# Note: OmniSharp, netcoredbg, and other LSP servers 
# will be installed automatically via Mason in Neovim
```

### Step 2: Setup Config Directory

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# Clean old data
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Create directory structure
mkdir -p ~/.config/nvim/lua/{plugins,config}
```

### Step 3: Create Configuration Files

**Important**: LazyVim is installed automatically through the config files. When you create `init.lua` with the LazyVim import, it will be downloaded on first launch.

Create the following files in your `~/.config/nvim/` directory:

```
~/.config/nvim/
├── init.lua
└── lua/
    ├── config/
    │   ├── keymaps.lua
    │   └── razor.lua
    └── plugins/
        ├── csharp.lua
        ├── completion.lua
        ├── database.lua
        ├── git-docker.lua
        ├── razor.lua
        └── extras.lua
```

Copy the content from the artifacts I've created above into each respective file.

### Step 4: First Launch

```bash
nvim
```

On first launch, this happens automatically:
1. **Lazy.nvim bootstraps** (downloads itself to `~/.local/share/nvim/lazy/`)
2. **LazyVim installs** (the distribution framework)
3. **All plugins install** (telescope, neo-tree, lsp-config, etc.)
4. **Mason installs** LSP servers (omnisharp, razor-ls, dockerfile-ls, etc.)
5. **Treesitter installs** parsers (c_sharp, razor, html, css, javascript, etc.)
6. **DAP installs** adapters (netcoredbg)

This process takes 2-5 minutes. You'll see progress bars and installation messages.

**After installation completes:**
- Close Neovim: `:q`
- Reopen: `nvim`
- Everything should now work! ✨

## 🔧 Configuration

### Database Connections

Add PostgreSQL connections in DBUI:

1. Press `<leader>db` to open DBUI
2. Press `A` to add a new connection
3. Enter connection string: `postgresql://user:password@localhost:5432/dbname`
4. Connections are saved to `~/.local/share/nvim/db_ui/`

### Docker Setup

Make sure Docker Desktop is running for Docker features to work.

## ⌨️ Key Bindings

### General
- `<Space>` - Leader key
- `<leader>e` - Toggle file explorer
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers

### LSP
- `gd` - Go to definition
- `gr` - Find references
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename
- `<leader>cf` - Format code
- `[d` / `]d` - Previous/Next diagnostic

### Git
- `<leader>gg` - LazyGit
- `<leader>gf` - LazyGit current file
- `<leader>ghs` - Stage hunk
- `<leader>ghr` - Reset hunk
- `<leader>ghp` - Preview hunk

### Docker & Database
- `<leader>dd` - LazyDocker
- `<leader>db` - Toggle DBUI
- `<leader>da` - Add DB connection

### Buffer Management
- `[b` / `]b` - Previous/Next buffer
- `<leader>bp` - Pin buffer
- `<leader>bo` - Close other buffers

### Window Navigation
- `<C-h/j/k/l>` - Navigate windows
- `<C-Up/Down/Left/Right>` - Resize windows

## 🚀 Working with .NET Projects

### Opening Solutions

```bash
# Navigate to solution directory
cd /path/to/your/solution

# Open Neovim
nvim .

# OmniSharp will automatically detect .sln files
```

### Building and Running

Use the integrated terminal:
- `:terminal` - Open terminal
- `dotnet build` - Build solution
- `dotnet run` - Run project
- `dotnet watch` - Hot reload

### Debugging

1. Set breakpoints with `:lua require'dap'.toggle_breakpoint()`
2. Start debugging with `:lua require'dap'.continue()`
3. Step through code with DAP commands

## 📝 Project Structure Support

The config supports:
- Multi-project solutions (.sln)
- Blazor WebAssembly (.razor, .cshtml)
- Class libraries (.csproj)
- Web APIs (Controllers, Minimal APIs)
- Entity Framework (Migrations, DbContext)
- MAUI projects (.xaml, .cs)

## 🔄 Syncing Config Across Machines

1. Initialize git in your config directory:
```bash
cd ~/.config/nvim
git init
git add .
git commit -m "Initial LazyVim config"
git remote add origin <your-repo-url>
git push -u origin main
```

2. On a new machine:
```bash
# Install dependencies (run install.sh)
./install.sh

# Clone your config
git clone <your-repo-url> ~/.config/nvim

# Launch Neovim (everything auto-installs)
nvim
```

## 🛠️ Troubleshooting

### OmniSharp not working
```bash
# Check OmniSharp installation
:Mason

# Reinstall OmniSharp
:MasonUninstall omnisharp
:MasonInstall omnisharp
```

### LSP not attaching
```bash
# Check LSP status
:LspInfo

# Restart LSP
:LspRestart
```

### Database connections not working
- Ensure PostgreSQL is installed and running
- Check connection string format
- Verify libpq is installed: `brew list libpq`

### Docker features not working
- Ensure Docker Desktop is running
- Check Docker daemon: `docker ps`
- Verify lazydocker installation: `which lazydocker`

## 📚 Additional Resources

- [LazyVim Documentation](https://www.lazyvim.org/)
- [OmniSharp Documentation](https://github.com/OmniSharp/omnisharp-roslyn)
- [Dadbod Documentation](https://github.com/kristijanhusak/vim-dadbod-ui)
- [LazyGit Documentation](https://github.com/jesseduffield/lazygit)

## 🎨 Customization

To customize further, edit files in `~/.config/nvim/lua/plugins/` and restart Neovim.

## 📦 Installed Packages

### Core
- LazyVim (base distribution)
- lazy.nvim (plugin manager)
- Telescope (fuzzy finder)
- Neo-tree (file explorer)
- Which-key (keybinding hints)

### LSP & Completion
- nvim-lspconfig
- mason.nvim
- omnisharp (C# LSP)
- razor-language-server (Blazor)
- nvim-cmp (completion)
- LuaSnip (snippets)

### Git
- gitsigns.nvim
- lazygit.nvim

### Docker
- lazydocker.nvim
- dockerfile-language-server
- docker-compose-language-service

### Database
- vim-dadbod
- vim-dadbod-ui
- vim-dadbod-completion

### Syntax
- nvim-treesitter (with C#, Razor, HTML, CSS, JS/TS parsers)

### UI
- lualine.nvim (statusline)
- bufferline.nvim (bufferline)
- indent-blankline.nvim
- nvim-web-devicons

### Utilities
- nvim-autopairs
- Comment.nvim
- nvim-dap (debugging)

## ✨ What's Auto-Installed

On first launch, everything is automatically installed:
- All plugins via Lazy.nvim
- LSP servers via Mason (omnisharp, razor-ls, dockerfile-ls, etc.)
- Treesitter parsers (c_sharp, razor, html, css, javascript, etc.)
- DAP adapters (netcoredbg)
- Formatters and linters

No manual `:TSInstall` or `:MasonInstall` commands needed!