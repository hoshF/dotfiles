return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = true,
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"bash",
			"lua",
			"rust",
			"c",
			"python",
			"json",
			"markdown",
			"markdown_inline",
		},
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
	},
}
