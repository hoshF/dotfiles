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
    config = function(_, opts)
        vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "FloatBorder" })

        local telescope = require("telescope")
        telescope.setup(opts)
        telescope.load_extension("fzf")
    end,
    opts = {
        defaults = {
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    width = 0.9,
                    height = 0.8,
                    preview_cutoff = 0,
                },
            },
            preview = true,
            sorting_strategy = "ascending",
            prompt_prefix = " λ ",
            selection_caret = "> ",
            entry_prefix = "  ",
            path_display = { "truncate" },
            color_devicons = true,
            borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            results_title = false,
            prompt_title = false,
            selection_highlight = "NONE",
            multi_icon = "",
            mappings = {
                i = {
                    ["<CR>"] = "select_tab",
                    ["<leader>"] = "select_default",
                    ["<C-v>"] = "select_vertical",
                    ["<C-x>"] = "select_horizontal",
                    ["<Tab>"] = "move_selection_next",
                    ["<S-Tab>"] = "move_selection_previous",
                    ["<C-u>"] = false,
                    ["<C-d>"] = false,
                },
                n = {
                    ["<CR>"] = "select_default",
                    ["<C-t>"] = "select_tab",
                    ["<C-v>"] = "select_vertical",
                    ["<C-x>"] = "select_horizontal",
                    ["j"] = "move_selection_next",
                    ["k"] = "move_selection_previous",
                },
            },
            file_ignore_patterns = {
                "node_modules/",
                "%.git/",
                "%.DS_Store",
                "target/",
                "build/",
                "dist/",
            },
        },
        pickers = {
            find_files = {
                hidden = false,
                no_ignore = false,
                search_dirs = { ".", "../", "../../" },
            },
            buffers = {
                show_all_buffers = true,
                sort_lastused = true,
                mappings = {
                    i = {
                        ["<C-d>"] = "delete_buffer",
                    },
                    n = {
                        ["dd"] = "delete_buffer",
                    },
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
}

