-- ~/.config/nvim/lua/plugins/easy-dotnet.lua
return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local dotnet = require("easy-dotnet")

			-- Configure easy-dotnet
			dotnet.setup({
				-- Roslyn LSP configuration
				lsp = {
					enabled = true, -- Use builtin Roslyn LSP
					roslynator_enabled = true,
					analyzer_assemblies = {},
					config = {},
				},

				-- Debugger configuration
				debugger = {
					bin_path = nil, -- Uses bundled netcoredbg
					apply_value_converters = true,
					auto_register_dap = true,
					mappings = {
						open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
					},
				},

				-- Test runner configuration
				test_runner = {
					viewmode = "float", -- "split" | "vsplit" | "float" | "buf"
					vsplit_width = nil,
					vsplit_pos = nil,
					enable_buffer_test_execution = true,
					noBuild = true,
					icons = {
						passed = "",
						skipped = "",
						failed = "",
						success = "",
						reload = "",
						test = "",
						sln = "󰘐",
						project = "󰘐",
						dir = "",
						package = "",
					},
					mappings = {
						run_test_from_buffer = { lhs = "<leader>r", desc = "run test from buffer" },
						peek_stack_trace_from_buffer = { lhs = "<leader>p", desc = "peek stack trace" },
						filter_failed_tests = { lhs = "<leader>fe", desc = "filter failed tests" },
						debug_test = { lhs = "<leader>d", desc = "debug test" },
						go_to_file = { lhs = "g", desc = "go to file" },
						run_all = { lhs = "<leader>R", desc = "run all tests" },
						run = { lhs = "<leader>r", desc = "run test" },
						peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace" },
						expand = { lhs = "o", desc = "expand" },
						expand_node = { lhs = "E", desc = "expand node" },
						expand_all = { lhs = "-", desc = "expand all" },
						collapse_all = { lhs = "W", desc = "collapse all" },
						close = { lhs = "q", desc = "close testrunner" },
						refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
					},
					additional_args = {},
				},

				-- Project creation
				new = {
					project = {
						prefix = "sln", -- "sln" | "none"
					},
				},

				-- Terminal function for running commands
				terminal = function(path, action, args)
					args = args or ""
					local commands = {
						run = function()
							return string.format("dotnet run --project %s %s", path, args)
						end,
						test = function()
							return string.format("dotnet test %s %s", path, args)
						end,
						restore = function()
							return string.format("dotnet restore %s %s", path, args)
						end,
						build = function()
							return string.format("dotnet build %s %s", path, args)
						end,
						watch = function()
							return string.format("dotnet watch --project %s %s", path, args)
						end,
					}
					local command = commands[action]()
					vim.cmd("vsplit")
					vim.cmd("term " .. command)
				end,

				-- File mappings
				csproj_mappings = true,
				fsproj_mappings = true,

				-- Auto bootstrap namespace
				auto_bootstrap_namespace = {
					type = "block_scoped", -- "block_scoped" | "file_scoped"
					enabled = true,
					use_clipboard_json = {
						behavior = "prompt", -- "auto" | "prompt" | "never"
						register = "+",
					},
				},

				-- Server configuration
				server = {
					log_level = nil, -- "Off" | "Critical" | "Error" | "Warning" | "Information" | "Verbose" | "All"
				},

				-- Picker preference
				picker = "telescope", -- "telescope" | "fzf" | "snacks" | "basic"

				-- Background scanning
				background_scanning = true,

				-- Notifications
				notifications = {
					handler = function(start_event)
						local spinner = require("easy-dotnet.ui-modules.spinner").new()
						spinner:start_spinner(start_event.job.name)
						return function(finished_event)
							spinner:stop_spinner(finished_event.result.msg, finished_event.result.level)
						end
					end,
				},

				-- Diagnostics
				diagnostics = {
					default_severity = "error",
					setqflist = false,
				},
			})

			-- Commands
			vim.api.nvim_create_user_command("DotnetRun", function()
				dotnet.run_project()
			end, {})

			vim.api.nvim_create_user_command("DotnetTest", function()
				dotnet.testrunner()
			end, {})

			vim.api.nvim_create_user_command("DotnetBuild", function()
				dotnet.build()
			end, {})

			-- Keymaps
			vim.keymap.set("n", "<leader>dr", dotnet.run_default, { desc = "Run default project" })
			vim.keymap.set("n", "<leader>dR", dotnet.run, { desc = "Run project" })
			vim.keymap.set("n", "<leader>db", dotnet.build, { desc = "Build" })
			vim.keymap.set("n", "<leader>dB", dotnet.build_default, { desc = "Build default" })
			vim.keymap.set("n", "<leader>dt", dotnet.testrunner, { desc = "Test runner" })
			vim.keymap.set("n", "<leader>dw", dotnet.watch_default, { desc = "Watch default" })
			vim.keymap.set("n", "<leader>dp", dotnet.project_view, { desc = "Project view" })
			vim.keymap.set("n", "<leader>dn", dotnet.new, { desc = "New template" })
			vim.keymap.set("n", "<leader>ds", dotnet.secrets, { desc = "User secrets" })
			vim.keymap.set("n", "<leader>do", dotnet.outdated, { desc = "Check outdated packages" })

			-- Entity Framework
			vim.keymap.set("n", "<leader>dem", function()
				vim.ui.input({ prompt = "Migration name: " }, function(name)
					if name then
						dotnet.ef_migrations_add(name)
					end
				end)
			end, { desc = "EF: Add migration" })
			vim.keymap.set("n", "<leader>der", dotnet.ef_migrations_remove, { desc = "EF: Remove migration" })
			vim.keymap.set("n", "<leader>del", dotnet.ef_migrations_list, { desc = "EF: List migrations" })
			vim.keymap.set("n", "<leader>deu", dotnet.ef_database_update, { desc = "EF: Update database" })
		end,
	},

	-- Razor syntax highlighting (HTML + C# in @code blocks)
	{
		"jlcrochet/vim-razor",
		ft = "razor",
	},

	-- Ensure Treesitter parsers for C# and related languages
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"c_sharp",
				"html",
				"css",
				"javascript",
				"typescript",
			})

			-- Ensure auto_install is enabled
			opts.auto_install = true

			-- Enable highlighting
			opts.highlight = opts.highlight or {}
			opts.highlight.enable = true
			opts.highlight.additional_vim_regex_highlighting = false
		end,
	},

	-- NVim-cmp source for package completion
	{
		"hrsh7th/nvim-cmp",
		optional = true,
		opts = function(_, opts)
			local cmp = require("cmp")
			cmp.register_source("easy-dotnet", require("easy-dotnet").package_completion_source)

			opts.sources = opts.sources or {}
			table.insert(opts.sources, { name = "easy-dotnet" })
		end,
	},
}
