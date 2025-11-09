return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local on_attach = function(client, _)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end

		-- lua
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")

		-- Rust
		vim.lsp.config("rust_analyzer", {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
						loadOutDirsFromCheck = true,
					},
					procMacro = {
						enable = true,
					},
					check = {
						command = "clippy",
					},
					rustc = {
						source = "discover",
					},
				},
			},
		})
		vim.lsp.enable("rust_analyzer")

		local other_servers = {
			"pylsp",
			"clangd",
			"gopls",
			"ts_ls",
			"texlab",
            "asm_lsp" -- asm-lsp gen-config
		}

		for _, server in ipairs(other_servers) do
			vim.lsp.config(server, {
				capabilities = capabilities,
				on_attach = on_attach,
			})
			vim.lsp.enable(server)
		end

		vim.diagnostic.config({
			virtual_text = false,
			signs = false,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})
	end,
}
