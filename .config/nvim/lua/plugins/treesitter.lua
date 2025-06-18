return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "*",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "c", "lua", "rust", "json", "bash", "markdown", "markdown_inline"
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<TAB>",
          scope_incremental = "<S-CR>",
          node_decremental = "<S-TAB>",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}

