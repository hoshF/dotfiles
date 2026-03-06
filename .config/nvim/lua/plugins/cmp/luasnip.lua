return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	dependencies = { "rafamadriz/friendly-snippets" },
	build = "make install_jsregexp",
	event = "BufReadpost",
	config = function()
		local luasnip = require("luasnip")

		luasnip.config.set_config({
			history = false,
			updateevents = "TextChanged,TextChangedI",
			enable_autosnippets = true,
			store_selection_keys = "<Tab>",
			ext_opts = nil,
		})

		require("luasnip.loaders.from_vscode").lazy_load()
		local snippet_path = vim.fn.expand("~/.config/nvim/LuaSnip/")
		if vim.fn.isdirectory(snippet_path) == 1 then
			require("luasnip.loaders.from_lua").load({ paths = { snippet_path } })
		end

		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }
		map({ "i", "s" }, "jk", function()
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				local keys = vim.api.nvim_replace_termcodes("<Right>", true, false, true)
				vim.api.nvim_feedkeys(keys, "n", true)
			end
		end, { desc = "LuaSnip: Jump forward" })

		map({ "i", "s" }, "kj", function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { desc = "LuaSnip: Jump backward" })

		map({ "i", "s" }, "<C-j>", function()
			if luasnip.choice_active() then
				luasnip.change_choice(1)
			end
		end, { desc = "LuaSnip: Next choice" })

		map({ "i", "s" }, "<C-n>", function()
			if luasnip.choice_active() then
				luasnip.change_choice(-1)
			end
		end, { desc = "LuaSnip: Previous choice" })

		map("n", "<leader>ls", function()
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })
			vim.notify("LuaSnip snippets reloaded!")
		end, { desc = "Reload LuaSnip snippets" })
	end,
}
