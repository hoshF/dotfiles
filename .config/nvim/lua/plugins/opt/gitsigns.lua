return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true,
		numhl = false,
		linehl = false,
		update_debounce = 200,
		watch_gitdir = { interval = 1000 },
	},
	keys = {
		{ "<leader>gp", function() require("gitsigns").preview_hunk() end, desc = "Preview hunk" },
		{ "<leader>gb", function() require("gitsigns").blame_line() end, desc = "Blame line" },
		{ "<leader>gd", function() require("gitsigns").diffthis() end, desc = "Diff this" },
	},
}
