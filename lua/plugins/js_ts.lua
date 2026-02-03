-- lua/plugins/js_ts.lua
return {
  -- Mason tools for JS/TS
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      local tools = {
        "eslint_d",
        "prettier",
        "biome",
      }
      for _, t in ipairs(tools) do
        if not vim.tbl_contains(opts.ensure_installed, t) then
          table.insert(opts.ensure_installed, t)
        end
      end
    end,
  },

  -- mason-lspconfig: ensure TS & ESLint
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      local servers = { "tsserver", "eslint" }
      for _, s in ipairs(servers) do
        if not vim.tbl_contains(opts.ensure_installed, s) then
          table.insert(opts.ensure_installed, s)
        end
      end
    end,
  },

  -- JS/TS Treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      local langs = { "javascript", "typescript", "tsx", "jsdoc" }
      for _, lang in ipairs(langs) do
        if not vim.tbl_contains(opts.ensure_installed, lang) then
          table.insert(opts.ensure_installed, lang)
        end
      end
    end,
  },
}
