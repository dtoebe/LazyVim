-- lua/config/keymaps.lua

local map = vim.keymap.set

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Clear search
map("n", "<leader>un", "<cmd>nohlsearch<cr>", { desc = "Clear search" })

-- Save / quit
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit all" })

-- Window navigation (works nicely with wezterm/zellij)
map("n", "<C-h>", "<C-w>h", { desc = "Left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Down window" })
map("n", "<C-k>", "<C-w>k", { desc = "Up window" })
map("n", "<C-l>", "<C-w>l", { desc = "Right window" })
