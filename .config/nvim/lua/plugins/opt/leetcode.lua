return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	cmd = "Leet",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		lang = "rust",
		cn = {
			enabled = true,
			translator = true,
			translate_problems = true,
		},
		storage = {
			home = vim.fn.stdpath("data") .. "/leetcode",
			cache = vim.fn.stdpath("cache") .. "/leetcode",
		},
		picker = {
			provider = "telescope",
		},
		editor = {
			reset_previous_code = false,
			fold_imports = true,
		},
		console = {
			open_on_runcode = true,
			dir = "row",
			size = { width = "90%", height = "75%" },
			result = { size = "60%" },
			testcase = { virt_text = true, size = "40%" },
		},
		description = {
			position = "left",
			width = "40%",
			show_stats = true,
		},
	},
}
