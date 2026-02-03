-- lua/plugins/go.lua
return {
  -- Go tools via Mason
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      local tools = {
        "delve",
        "gomodifytags",
        "impl",
      }
      for _, t in ipairs(tools) do
        if not vim.tbl_contains(opts.ensure_installed, t) then
          table.insert(opts.ensure_installed, t)
        end
      end
    end,
  },

  -- Go Treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      for _, lang in ipairs({ "go", "gomod", "gosum", "gowork" }) do
        if not vim.tbl_contains(opts.ensure_installed, lang) then
          table.insert(opts.ensure_installed, lang)
        end
      end
    end,
  },

  -- Go DAP
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-go").setup()
      vim.keymap.set("n", "<leader>dd", function()
        require("dap-go").debug_test()
      end, { desc = "Debug Go test" })
    end,
  },
}
