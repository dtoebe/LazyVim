-- ~/.config/nvim/init.lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
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

-- Set leader key before loading LazyVim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable LazyVim's default C# support (we're using easy-dotnet instead)
vim.g.lazyvim_csharp_lsp = "easy_dotnet"

-- Load LazyVim
require("lazy").setup({
	spec = {
		-- LazyVim core
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },

		-- Import all custom plugins
		{ import = "plugins" },
	},
	defaults = {
		lazy = false,
		version = false,
	},
	install = { colorscheme = { "tokyonight", "habamax" } },
	checker = { enabled = true },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.termguicolors = true
