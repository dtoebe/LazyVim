-- lua/plugins/devops.lua
return {
  -- Kubernetes & Helm helpers
  {
    "h4ckm1n-dev/kube-utils-nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("kube-utils").setup({})
      vim.keymap.set("n", "<leader>kk", "<cmd>KubeUtils<cr>", { desc = "Kube Utils" })
    end,
  },

  -- Devcontainer integration
  {
    "esensar/nvim-dev-container",
    ft = { "Dockerfile", "yaml", "yml" },
    config = function()
      require("devcontainer").setup({})
      vim.keymap.set("n", "<leader>dc", "<cmd>DevcontainerOpen<cr>", { desc = "Open devcontainer" })
    end,
  },

  -- DB: Postgres/Redis via vim-dadbod
  {
    "tpope/vim-dadbod",
    cmd = { "DB", "DBUI" },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI" },
    dependencies = { "tpope/vim-dadbod" },
    config = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.keymap.set("n", "<leader>db", "<cmd>DBUI<cr>", { desc = "Open DB UI" })
    end,
  },
}

