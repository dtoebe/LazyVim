-- lua/config/autocmds.lua

local api = vim.api

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Use relative number in active window only
api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  callback = function()
    vim.opt.relativenumber = true
  end,
})
api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
  callback = function()
    vim.opt.relativenumber = false
  end,
})
