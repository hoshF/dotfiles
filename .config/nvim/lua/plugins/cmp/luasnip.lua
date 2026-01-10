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
			ext_opts = nil,
		})

		vim.defer_fn(function()
			local ok, _ = pcall(require, "luasnip.loaders.from_vscode")
			if ok then
				require("luasnip.loaders.from_vscode").lazy_load()
			end

			local snippet_path = vim.fn.expand("~/.config/nvim/LuaSnip/")
			if vim.fn.isdirectory(snippet_path) == 1 then
				local ok2, _ = pcall(require("luasnip.loaders.from_lua").lazy_load, {
					paths = { snippet_path },
				})
				if not ok2 then
					vim.notify("Failed to load custom snippets", vim.log.levels.WARN)
				end
			end
		end, 100)
	end,
}
