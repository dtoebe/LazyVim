-- lua/config/options.lua

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.cursorline = true
opt.signcolumn = "yes"

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

opt.termguicolors = true
opt.clipboard = "unnamedplus"

opt.ignorecase = true
opt.smartcase = true

opt.splitright = true
opt.splitbelow = true

-- LazyVim Python knobs
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"
vim.g.lazyvim_python_venv = ".venv"

vim.g.venv_selector = {
	search = {
		cwd = true,
		workspace = true,
		parents = true,
	},
	uv = {
		enable = true,
	},
}
