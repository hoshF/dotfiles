return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && "
                .. "cmake --build build --config Release && "
                .. "cmake --install build --prefix build",
        },
    },
    cmd = "Telescope",
    opts = {
        defaults = {
            layout_strategy = "center",
            layout_config = {
                center = {
                    width = 0.7,
                    height = 0.4,
                },
            },
            preview = false,
            sorting_strategy = "ascending",
            prompt_prefix = "> ",
            selection_caret = "- ",
            path_display = { "smart" },
            color_devicons = false,
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            results_title = false,
            prompt_title = false,

            mappings = {
                i = {
                    ["<CR>"] = function(prompt_bufnr)
                        local actions = require("telescope.actions")
                        actions.select_tab(prompt_bufnr)
                    end,
                },
                n = {
                    ["<CR>"] = function(prompt_bufnr)
                        local actions = require("telescope.actions")
                        actions.select_tab(prompt_bufnr)
                    end,
                },

            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    },
    config = function(_, opts)
        local telescope = require "telescope"
        telescope.setup(opts)
        telescope.load_extension("fzf")
    end,
}
