-- lua/plugins/csharp.lua
return {
  -- C# LSP via omnisharp
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = {
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
        },
      },
    },
  },

  -- C# Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if not vim.tbl_contains(opts.ensure_installed, "c_sharp") then
        table.insert(opts.ensure_installed, "c_sharp")
      end
    end,
  },
}
