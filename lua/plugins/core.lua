-- ~/.config/nvim/lua/plugins/core.lua
return {
	-- Dracula theme
	{
		"Mofiqul/dracula.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("dracula")
		end,
	},

	-- Mason from mason-org
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ui = {
				border = "rounded",
			},
		},
	},

	-- mason-lspconfig: ensure LSP servers
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}

			local servers = {
				"gopls",
				"ts_ls",
				"eslint",
				"jsonls",
				"lua_ls",
				"bashls",
				"yamlls",
				"dockerls",
				"docker_compose_language_service",
				"helm_ls",
				"omnisharp",
				"markdown_oxide",
				"pyright",
				"ruff_lsp",
			}

			for _, s in ipairs(servers) do
				if not vim.tbl_contains(opts.ensure_installed, s) then
					table.insert(opts.ensure_installed, s)
				end
			end
		end,
	},

	-- mason-null-ls: formatters & linters
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = { "mason-org/mason.nvim", "nvimtools/none-ls.nvim" },
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}

			local tools = {
				"golangci-lint",
				"goimports",
				"gofumpt",
				"stylua",
				"prettier",
				"eslint_d",
				"hadolint",
				"yamllint",
				"jsonlint",
				"markdownlint",
				"black",
				"ruff",
				"isort",
			}

			for _, t in ipairs(tools) do
				if not vim.tbl_contains(opts.ensure_installed, t) then
					table.insert(opts.ensure_installed, t)
				end
			end
		end,
	},

	-- Treesitter global base (languages added in language files)
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			local base = {
				"lua",
				"bash",
				"json",
				"yaml",
				"markdown",
				"markdown_inline",
				"dockerfile",
				"toml",
				"regex",
				"vim",
				"vimdoc",
			}
			for _, lang in ipairs(base) do
				if not vim.tbl_contains(opts.ensure_installed, lang) then
					table.insert(opts.ensure_installed, lang)
				end
			end
		end,
	},

	-- Telescope keymaps
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
		},
	},
}
