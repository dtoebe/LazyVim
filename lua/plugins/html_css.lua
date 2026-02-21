return {
	-- LSP servers
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				-- HTML
				html = {
					filetypes = { "html", "htm", "templ" },
				},
				-- CSS / SCSS / Less
				cssls = {
					filetypes = { "css", "scss", "less" },
					settings = {
						css = {
							validate = true,
						},
						scss = {
							validate = true,
						},
						less = {
							validate = true,
						},
					},
				},
			},
		},
	},

	-- Ensure tools are installed via mason
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"html-lsp", -- html
				"css-lsp", -- cssls
				"prettier", -- formatter
			})
		end,
	},

	-- Formatting (conform.nvim – default in LazyVim)
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				less = { "prettier" },
				-- you can add: javascript, typescript, etc. here too
			},
		},
	},

	-- Diagnostics/linting via none-ls (optional)
	{
		"nvimtools/none-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.sources = opts.sources or {}
			vim.list_extend(opts.sources, {
				nls.builtins.diagnostics.stylelint, -- if you use stylelint
			})
		end,
	},
}
