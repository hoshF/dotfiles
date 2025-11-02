return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = "ConformInfo",
	keys = {
		{
			"<space>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},  -- ← keys 在这里结束
	opts = {  -- ← opts 应该和 keys 平级
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
		default_format_opts = {
			lsp_fallback = true,
		},
		notify_on_error = true,
	},
}
