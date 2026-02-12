return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.servers = opts.servers or {}
			opts.servers.emmet_ls = vim.tbl_deep_extend("force", opts.servers.emmet_ls or {}, {
				filetypes = {
					"html",
					"css",
					"scss",
					"sass",
					"less",
					"javascriptreact",
					"typescriptreact",
					"javascript",
					"typescript",
					"markdown",
					-- add more as needed, e.g. "ejs"
				},
				init_options = {
					html = {
						options = {
							["bem.enabled"] = true,
						},
					},
				},
			})
		end,
	},
}
