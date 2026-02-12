return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				tailwindcss = {
					-- tweak filetypes if you want; defaults work for most setups
					-- filetypes_include / filetypes_exclude also supported in LazyVim extra
				},
			},
		},
	},
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"tailwindcss-language-server",
			})
		end,
	},
	-- Optional: Tailwind colorized class names via mini.hipatterns
	{
		"echasnovski/mini.hipatterns",
		optional = true,
		opts = function()
			local hi = require("mini.hipatterns")
			return {
				tailwind = {
					enabled = true,
					ft = {
						"astro",
						"css",
						"heex",
						"html",
						"html-eex",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"svelte",
					},
				},
			}
		end,
	},
}
