-- ~/.config/nvim/init.lua

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Basic options
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.signcolumn = "yes"

-- Install lazy.nvim (plugin manager) if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load basic config (keymaps, options, autocmds)
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Plugin setup with lazy.nvim
require("lazy").setup({
	-- 1) LazyVim core and extras
	{
		"LazyVim/LazyVim",
		import = "lazyvim.plugins",
	},

	-- Language / feature extras (LazyVim modules)
	{ import = "lazyvim.plugins.extras.lang.typescript" },
	{ import = "lazyvim.plugins.extras.lang.json" },
	{ import = "lazyvim.plugins.extras.lang.docker" },
	{ import = "lazyvim.plugins.extras.lang.go" },
	{ import = "lazyvim.plugins.extras.lang.python" }, -- helper tools / devcontainers
	{ import = "lazyvim.plugins.extras.dap.core" },
	{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },
	{ import = "lazyvim.plugins.extras.lang.markdown" },
	{ import = "lazyvim.plugins.extras.util.rest" }, -- ← add this[web:202]

	-- 2) Your plugins (local)
	{ import = "plugins.core" },
	{ import = "plugins.go" },
	{ import = "plugins.flutter" },
	{ import = "plugins.js_ts" },
	{ import = "plugins.csharp" },
	{ import = "plugins.git" },
	{ import = "plugins.devops" },
	{ import = "plugins.flash" }, -- ← add this so your flash.lua override is loaded
	{ import = "plugins.bootstrap_css" },
	{ import = "plugins.emmit" },
	{ import = "plugins.html_css" },
	{ import = "plugins.htmx" },
	{ import = "plugins.python" },
	{ import = "plugins.go-testing" },
}, {
	defaults = {
		lazy = true,
	},
	checker = {
		enabled = false,
	},
})
