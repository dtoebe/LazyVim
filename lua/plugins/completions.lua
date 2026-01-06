-- ~/.config/nvim/lua/plugins/git-docker.lua
return {
	-- LazyGit integration
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
			{ "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit Current File" },
			{ "<leader>gc", "<cmd>LazyGitConfig<cr>", desc = "LazyGit Config" },
		},
	},

	-- LazyDocker integration
	{
		"crnvl96/lazydocker.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<leader>dd", "<cmd>LazyDocker<cr>", desc = "LazyDocker" },
		},
	},

	-- Docker Compose support
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"dockerfile",
				"yaml",
			})
		end,
	},

	-- Docker LSP
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"dockerfile-language-server",
				"docker-compose-language-service",
				"yaml-language-server",
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				dockerls = {},
				docker_compose_language_service = {},
				yamlls = {
					settings = {
						yaml = {
							schemas = {
								["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.{yml,yaml}",
							},
						},
					},
				},
			},
		},
	},

	-- Gitsigns for git decorations
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				map("n", "]h", gs.next_hunk, "Next Hunk")
				map("n", "[h", gs.prev_hunk, "Prev Hunk")
				map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<leader>ghd", gs.diffthis, "Diff This")
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, "Diff This ~")
			end,
		},
	},
}
