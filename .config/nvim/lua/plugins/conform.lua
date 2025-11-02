return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	opts = {
		async = true,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			rust = { "rustfmt" },
			go = { "gofmt" },
			c = { "clang-format" },
			asm = { "asmfmt" },
			tex = { "latexindent" },
			html = { "prettierd" },
			htmldjango = { "prettierd" },
			handlebars = { "prettierd" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd", "eslint_d" },
			typescript = { "prettierd", "eslint_d" },
			typescriptreact = { "prettierd", "eslint_d" },
			json = { "prettierd" },
			css = { "prettierd" },
		},
		formatters = {
			["clang-format"] = {
				prepend_args = {
					"--style={IndentWidth: 4, TabWidth: 4, UseTab: Never}",
				},
			},
		},
		fallback_lsp_format = true,
		notify_on_error = true,
	},
}
