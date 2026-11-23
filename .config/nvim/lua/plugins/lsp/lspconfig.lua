return {
	{
		"mason-org/mason.nvim",
		event = "BufReadPost",
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
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		cmd = { "MasonToolsInstall", "MasonToolsVerify" },
		opts = {
			ensure_installed = {
				"lua-language-server",
				"rust-analyzer",
				"clangd",
				"gopls",
				"texlab",
				"asm-lsp",
				"pyright",
				"vtsls",
				"yaml-language-server",
				"json-lsp",

				"clang-format",
				"asmfmt",
				"tex-fmt",
				"prettierd",
				"eslint_d",
				"shfmt",
			},
			run_on_start = false,
		},
		config = function(_, opts)
			require("mason-tool-installer").setup(opts)
			vim.api.nvim_create_user_command("MasonToolsVerify", function()
				local registry = require("mason-registry")
				local failed = {}
				for _, name in ipairs(opts.ensure_installed) do
					local ok, valid = pcall(function()
						local package = registry.get_package(name)
						if not package:is_installed() then
							return false
						end
						local receipt = package:get_receipt()
						return receipt:is_present() and receipt:get():get_name() == name
					end)
					if not ok or not valid then
						table.insert(failed, name)
					end
				end
				if #failed > 0 then
					vim.notify(
						"Mason verification failed (missing package or invalid receipt): " .. table.concat(failed, ", "),
						vim.log.levels.ERROR
					)
					if #vim.api.nvim_list_uis() == 0 then
						vim.cmd("cquit 1")
					end
					return
				end
				vim.notify("Mason tools verified: " .. #opts.ensure_installed .. " packages installed.")
			end, { desc = "Verify configured Mason packages without installing" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-org/mason.nvim", "saghen/blink.cmp" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local on_attach = function(client, _)
				client.server_capabilities.semanticTokensProvider = nil
			end

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
						format = { enable = true },
					},
				},
			})
			vim.lsp.enable("lua_ls")

			vim.lsp.config("rust_analyzer", {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					["rust-analyzer"] = {
						files = {
							watcher = "server",
						},
						cargo = {
							allFeatures = true,
						},
						procMacro = {
							enable = true,
						},
						check = {
							command = "clippy",
						},
					},
				},
			})
			vim.lsp.enable("rust_analyzer")

			local server_filetypes = {
				clangd = { "c", "cpp" },
				gopls = "go",
				texlab = "tex",
				asm_lsp = { "asm" },
				pyright = "python",
				vtsls = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
				yamlls = { "yaml", "yml" },
				jsonls = { "json", "jsonc" },
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
				virtual_text = {
					spacing = 2,
					prefix = "●",
					source = false,
				},
				signs = false,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
		end,
	},
}
