return {
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"rust_analyzer",
				"clangd",
				"lua_ls",
				"gopls",
				"texlab",
				"asm_lsp",
				"pyright",
				"ts_ls",
			},
			automatic_installation = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local on_attach = function(client, _)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
				client.server_capabilities.semanticTokensProvider = nil
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
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
						hint = { enable = false },
						format = { enable = false },
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

			local server_filetypes = {
				clangd = { "c", "cpp" },
				gopls = "go",
				texlab = "tex",
				asm_lsp = { "asm", "s", "S" },
				pyright = "python",
				ts_ls = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
			}

			for server, ft in pairs(server_filetypes) do
				vim.lsp.config(server, {
					capabilities = capabilities,
					on_attach = on_attach,
					filetypes = type(ft) == "table" and ft or { ft },
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
	},
}
