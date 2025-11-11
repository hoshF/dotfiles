return {
	{ "mason-org/mason.nvim", opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"pylsp",
				"rust_analyzer",
				"clangd",
				"lua_ls",
				"gopls",
				"ts_ls",
				"texlab",
				"asm_lsp",
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
					pylsp = "python",
					clangd = { "c", "cpp" },
					gopls = "go",
					ts_ls = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
					texlab = "tex",
					asm_lsp = "asm",
				}

				for server, ft in pairs(server_filetypes) do
					vim.api.nvim_create_autocmd("FileType", {
						pattern = ft,
						once = true,
						callback = function()
							vim.lsp.config(server, {
								capabilities = capabilities,
								on_attach = on_attach,
							})
							vim.lsp.enable(server)
						end,
					})
				end

				-- local other_servers = {
				-- 	"pylsp",
				-- 	"clangd",
				-- 	"gopls",
				-- 	"ts_ls",
				-- 	"texlab",
				-- 	"asm_lsp", -- asm-lsp gen-config
				-- }

				-- for _, server in ipairs(other_servers) do
				-- 	vim.lsp.config(server, {
				-- 		capabilities = capabilities,
				-- 		on_attach = on_attach,
				-- 	})
				-- 	vim.lsp.enable(server)
				-- end

				vim.diagnostic.config({
					virtual_text = false,
					signs = false,
					underline = true,
					update_in_insert = false,
					severity_sort = true,
				})
			end,
		},
	},
}
