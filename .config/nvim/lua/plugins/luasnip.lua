return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    event = "InsertEnter",
    config = function()

        local luasnip = require("luasnip")
        luasnip.config.set_config({
            history = false,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true,
            store_selection_keys = "<Tab>",
        })

        require("luasnip.loaders.from_lua").lazy_load({
            paths = { "~/.config/nvim/LuaSnip/" },
        })
    end,
}
