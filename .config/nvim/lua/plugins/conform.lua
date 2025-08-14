return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	opts = {
		async = true,
		lsp_format = false,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			rust = { "rustfmt" },
			go = { "gopls" },
		},
	},
}
