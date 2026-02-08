-- lua/plugins/python.lua
return {
	{
		"linux-cultist/venv-selector.nvim",
		opts = function(_, opts)
			opts = opts or {}
			opts.search = vim.tbl_deep_extend("force", {
				cwd = true,
				workspace = true,
				parents = true,
			}, opts.search or {})

			opts.uv = vim.tbl_deep_extend("force", {
				enable = true,
			}, opts.uv or {})

			return opts
		end,
	},
}
