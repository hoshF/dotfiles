return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            sign = { enabled = false },
            heading = { icons = { '󰼏 ', '󰎨 ' }, position = 'inline' },
            bullet = { left_pad = 4 },
            code = { style = 'normal' },
            render_modes = { 'n', 'c', 't' },

        },
    },
}
