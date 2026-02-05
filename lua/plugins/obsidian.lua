-- lua/plugins/obsidian.lua
return {
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- use latest release for stability[web:146][web:153]
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			-- Change this to your vault path
			workspaces = {
				{
					name = "Personal",
					path = "~/Documents/Obsidian/Personal", -- e.g. your main vault
				},
				{
					name = "Toebe Consulting",
					path = "~/Documents/Obsidian/Toebe Consulting", -- e.g. your main vault
				},
			},

			-- Use [[wiki-links]] and follow them
			wiki_link_func = "use_alias_only",

			-- Detect frontmatter title as note title
			ui = {
				enable = true,
			},

			-- Completion & mappings (keep simple; LazyVim handles completion UI)
			completion = {
				nvim_cmp = true,
			},

			-- Optional: use Obsidian-style daily notes
			daily_notes = {
				folder = "Daily",
			},
		},
		config = function(_, opts)
			require("obsidian").setup(opts)

			-- Keymaps for Obsidian features
			local map = vim.keymap.set
			-- Open today’s daily note
			map("n", "<leader>od", "<cmd>ObsidianToday<cr>", { desc = "Obsidian Today" })
			-- Open note picker
			map("n", "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Obsidian Quick Switch" })
			-- New note
			map("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "Obsidian New Note" })
			-- Follow link under cursor ([[link]])
			map("n", "gf", "<cmd>ObsidianFollowLink<cr>", { desc = "Obsidian Follow Link" })
			-- Show backlinks
			map("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { desc = "Obsidian Backlinks" })
		end,
	},
}
