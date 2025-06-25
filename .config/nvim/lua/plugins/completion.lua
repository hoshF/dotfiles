return {
    {
        "saghen/blink.cmp",
        version = "1.*",
        dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },

        opts = {
            keymap = {
                preset = "enter",
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
            },


            appearance = {
                nerd_font_variant = "mono",
            },

            snippets = { preset = 'luasnip' },

            sources = {
                default = { "lsp", "path", "buffer" },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" },
            completion = {
                keyword = { range = "prefix" },
                menu = {
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
                trigger = { show_on_trigger_character = true,
                    show_in_snippet = false,
                },
                documentation = {
                    auto_show = true,
                },
            },

            signature = { enabled = true },
        },
        opts_extend = { "sources.default" },
    },
}
