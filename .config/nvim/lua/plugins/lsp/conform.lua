return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = "ConformInfo",
	keys = {
		{
			"<space>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			rust = { "rustfmt" },
			go = { "gofmt" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			asm = { "asmfmt" },
			tex = { "tex-fmt" },
			html = { "prettierd" },
			markdown = { "prettierd" },
			htmldjango = { "prettierd" },
			handlebars = { "prettierd" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd", "eslint_d" },
			typescript = { "prettierd", "eslint_d" },
			typescriptreact = { "prettierd", "eslint_d" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			css = { "prettierd" },
			yaml = { "prettierd" },
			yml = { "prettierd" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "shfmt" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		notify_on_error = true,
	},
}
