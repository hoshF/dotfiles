return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<CR>"] = actions.select_tab,
            },
            n = {
              ["<CR>"] = actions.select_tab,
            },
          },
          layout_strategy = "vertical",
          layout_config = {
            vertical = { width = 0.8 },
          },
          sorting_strategy = "ascending",
        },
      })
    end,
  },
}

