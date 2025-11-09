return {
	"folke/trouble.nvim",
	dependencies = { "neovim/nvim-lspconfig" },
	cmd = { "Trouble" },
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle Trouble diagnostics" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Toggle Trouble quickfix" },
	},
	opts = {
		mode = "diagnostics",
		auto_close = true,
		auto_refresh = true,
		focus = true,
		follow = true,
		indent_guides = true,
		max_items = 200,
		multiline = true,
		win = {
			position = "bottom",
			size = 12,
		},
		preview = {
			scratch = true,
		},
		keys = {
			["q"] = "close",
			["<esc>"] = "close",
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
	config = function(_, opts)
		require("trouble").setup(opts)
		vim.api.nvim_create_autocmd("User", {
			pattern = "TroubleOpen",
			callback = function() vim.cmd("wincmd J") end,
		})
	end,
}
