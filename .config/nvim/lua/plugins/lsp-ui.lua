return {
    -- Enhanced LSP UI with Lspsaga
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        config = function()
            require("lspsaga").setup({
                ui = {
                    border = "rounded",
                    winblend = 0,
                    expand = "󰅀",
                    collapse = "󰅂",
                    code_action = "💡",
                    actionfix = " ",
                    lines = { "┗", "┣", "┃", "━", "┏" },
                    kind = nil,
                    imp_sign = "󰳛 ",
                },
                hover = {
                    max_width = 0.9,
                    max_height = 0.8,
                    open_link = "gx",
                },
                diagnostic = {
                    show_code_action = true,
                    show_layout = "float",
                    jump_num_shortcut = true,
                    max_width = 0.8,
                    max_height = 0.6,
                    text_hl_follow = true,
                    border_follow = true,
                    extend_relatedInformation = false,
                    keys = {
                        exec_action = "o",
                        quit = "q",
                        expand_or_jump = "<CR>",
                        quit_in_show = { "q", "<ESC>" },
                    },
                },
                code_action = {
                    num_shortcut = true,
                    show_server_name = false,
                    extend_gitsigns = true,
                    keys = {
                        quit = "q",
                        exec = "<CR>",
                    },
                },
                lightbulb = {
                    enable = false,
                    sign = false,
                    virtual_text = false,
                },
                finder = {
                    max_height = 0.5,
                    left_width = 0.4,
                    default = "ref+imp",
                    layout = "float",
                    silent = false,
                    keys = {
                        shuttle = "[w",
                        toggle_or_req = "o",
                        vsplit = "s",
                        split = "i",
                        tabe = "t",
                        quit = "q",
                    },
                },
                definition = {
                    width = 0.6,
                    height = 0.5,
                    keys = {
                        edit = "<C-c>o",
                        vsplit = "<C-c>v",
                        split = "<C-c>i",
                        tabe = "<C-c>t",
                        quit = "q",
                    },
                },
                rename = {
                    in_select = true,
                    auto_save = false,
                    project_max_width = 0.5,
                    project_max_height = 0.5,
                    keys = {
                        quit = "<C-k>",
                        exec = "<CR>",
                        select = "x",
                    },
                },
                symbol_in_winbar = {
                    enable = true,
                    separator = " › ",
                    hide_keyword = true,
                    show_file = true,
                    folder_level = 2,
                    color_mode = true,
                    delay = 300,
                },
                outline = {
                    win_position = "right",
                    win_width = 30,
                    auto_preview = false,
                    auto_refresh = true,
                    auto_close = true,
                    keys = {
                        toggle_or_jump = "o",
                        quit = "q",
                        jump = "e",
                    },
                },
            })
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
    },

    -- Inline diagnostic display
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        event = "LspAttach",
        config = function()
            require("lsp_lines").setup()
            -- Start with virtual lines disabled
            vim.diagnostic.config({ virtual_lines = false })
        end,
    },
}
