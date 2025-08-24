return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	dependencies = { "rafamadriz/friendly-snippets" },
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

		vim.defer_fn(function()
			require("luasnip.loaders.from_vscode").lazy_load()

			local snippet_path = vim.fn.expand("~/.config/nvim/LuaSnip/")
			if vim.fn.isdirectory(snippet_path) == 1 then
				require("luasnip.loaders.from_lua").lazy_load({
					paths = { snippet_path },
				})
			end
		end, 50)
	end,
}
