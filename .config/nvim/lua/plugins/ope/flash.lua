return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		labels = "asdfghjklqwertyuiopzxcvbnm",
		search = {
			multi_window = true,
			incremental = true,
			exclude = { "notify", "cmp_menu", "noice", "neo-tree", "TelescopePrompt" },
		},
		modes = {
			char = {
				enabled = false,
			},
			search = {
				enabled = true,
				highlight = { backdrop = true },
				jump = { pos = "start" },
			},
			treesitter = {
				jump = { pos = "range" },
				highlight = { backdrop = true, matches = true },
			},
		},
		highlight = {
			backdrop = true,
			matches = true,
			priority = 5000,
		},
		jump = {
			autojump = false,
			nohlsearch = true,
		},
		label = {
			uppercase = false,
			rainbow = { enabled = false },
		},
		prompt = {
			enabled = true,
			prefix = { { "⚡", "FlashPromptIcon" } },
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash Jump",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<C-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
	},
}
