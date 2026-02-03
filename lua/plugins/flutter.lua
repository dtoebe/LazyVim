-- lua/plugins/flutter.lua
return {
  {
    "akinsho/flutter-tools.nvim",
    ft = { "dart" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      require("flutter-tools").setup({
        flutter_path = "flutter", -- assumes flutter in PATH
        widget_guides = { enabled = true },
        closing_tags = {
          highlight = "Comment",
          prefix = "//",
          enabled = true,
        },
        dev_log = { enabled = true, open_cmd = "tabedit" },
        lsp = {
          color = { enabled = true },
          on_attach = function(_, bufnr)
            local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end
            map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
            map("n", "K", vim.lsp.buf.hover, "Hover")
          end,
        },
      })

      vim.keymap.set("n", "<leader>fr", "<cmd>FlutterRun<cr>", { desc = "Flutter Run" })
      vim.keymap.set("n", "<leader>fR", "<cmd>FlutterRestart<cr>", { desc = "Flutter Restart" })
      vim.keymap.set("n", "<leader>fq", "<cmd>FlutterQuit<cr>", { desc = "Flutter Quit" })
      vim.keymap.set("n", "<leader>fd", "<cmd>FlutterDevices<cr>", { desc = "Flutter Devices" })
    end,
  },

  -- Disable Dart Treesitter (avoid crashes)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      -- Remove dart if present
      opts.ensure_installed = vim.tbl_filter(function(lang)
        return lang ~= "dart"
      end, opts.ensure_installed)

      -- Extra safety: stop Treesitter in Dart buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dart",
        callback = function()
          pcall(function()
            vim.treesitter.stop()
          end)
        end,
      })
    end,
  },
}
