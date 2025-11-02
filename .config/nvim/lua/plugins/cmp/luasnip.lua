return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	dependencies = { "rafamadriz/friendly-snippets" },
	build = "make install_jsregexp",
	event = "InsertEnter",
	keys = {
		{
			"jk",
			function()
				local luasnip = require("luasnip")
				if luasnip.jumpable(1) then
					luasnip.jump(1)
				end
			end,
			mode = { "i", "s" },
			desc = "LuaSnip: Jump forward",
		},
		{
			"kj",
			function()
				local luasnip = require("luasnip")
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end,
			mode = { "i", "s" },
			desc = "LuaSnip: Jump backward",
		},
		{
			"<C-j>",
			function()
				local luasnip = require("luasnip")
				if luasnip.choice_active() then
					luasnip.change_choice(1)
				end
			end,
			mode = { "i", "s" },
			desc = "LuaSnip: Next choice",
		},
		{
			"<C-n>",
			function()
				local luasnip = require("luasnip")
				if luasnip.choice_active() then
					luasnip.change_choice(-1)
				end
			end,
			mode = { "i", "s" },
			desc = "LuaSnip: Previous choice",
		},
		{
			"<leader>ls",
			function()
				require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })
				vim.notify("LuaSnip snippets reloaded!")
			end,
			desc = "Reload LuaSnip snippets",
		},
	},
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
