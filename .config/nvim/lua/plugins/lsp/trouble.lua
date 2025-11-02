return {
	"folke/trouble.nvim",
	dependencies = { "neovim/nvim-lspconfig" },
	cmd = "Trouble",
	opts = {
		focus = true,
		follow = true,
		indent_guides = true,
		max_items = 200,
		multiline = true,
		auto_close = true,
		auto_refresh = true,

		win = {
			position = "bottom",
			size = 12,
		},

		preview = {
			scratch = true,
		},

		keys = {
			["q"] = "close",
			["<esc>"] = "cancel",
			["<cr>"] = "jump_close",
			["o"] = "jump",
			["p"] = "preview",
			["r"] = "refresh",
			["j"] = "next",
			["k"] = "prev",
			["<C-v>"] = "jump_vsplit",
			["<C-x>"] = "jump_split",
		},
	},
}
