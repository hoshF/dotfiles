return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
	},
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
