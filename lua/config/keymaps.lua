-- ~/.config/nvim/lua/config/keymaps.lua
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Restore default 's' behavior (substitute character)
keymap("n", "s", "s", { noremap = true, desc = "Substitute character" })
keymap("x", "s", "s", { noremap = true, desc = "Substitute selection" })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Clear search highlighting
keymap("n", "<leader>h", ":nohlsearch<CR>", opts)

-- Save file
keymap("n", "<C-s>", ":w<CR>", opts)

-- Quit
keymap("n", "<C-q>", ":q<CR>", opts)

-- Better escape
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- LSP keymaps (these will be set when LSP attaches)
keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "References" })
keymap("n", "<leader>cf", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format" })

-- Diagnostic keymaps
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
keymap("n", "<leader>cl", vim.diagnostic.setloclist, { desc = "Diagnostic loclist" })
