return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	event = "VeryLazy",
	opts = {
		ensure_installed = {
			"pylsp",
			"rust_analyzer",
			"clangd",
			"lua_ls",
			"gopls",
		},
	},
}
