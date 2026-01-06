-- ~/.config/nvim/lua/plugins/database.lua
return {
  -- Dadbod for database interaction
  {
    "tpope/vim-dadbod",
    lazy = true,
  },

  -- Dadbod UI
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- DB UI settings
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_force_echo_notifications = 1
      vim.g.db_ui_win_position = "right"
      vim.g.db_ui_winwidth = 40

      -- Save database connections in a separate file
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"

      -- Auto execute on save
      vim.g.db_ui_execute_on_save = 0
    end,
    keys = {
      { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
      { "<leader>df", "<cmd>DBUIFindBuffer<cr>", desc = "Find DBUI Buffer" },
      { "<leader>da", "<cmd>DBUIAddConnection<cr>", desc = "Add DB Connection" },
    },
  },

  -- Dadbod completion for nvim-cmp
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = "hrsh7th/nvim-cmp",
    ft = { "sql", "mysql", "plsql", "pgsql" },
    config = function()
      require("cmp").setup.filetype({ "sql", "mysql", "plsql", "pgsql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        },
      })
    end,
  },
}
