return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")

            -- Global diagnostic configuration
            vim.diagnostic.config({
                virtual_text = {
                    prefix = "●",
                    spacing = 4,
                    severity = { min = vim.diagnostic.severity.WARN },
                },
                signs = {
                    severity = { min = vim.diagnostic.severity.HINT },
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                        [vim.diagnostic.severity.INFO] = " ",
                    },
                },
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "if_many",
                    header = "",
                    prefix = "",
                    max_width = 80,
                    max_height = 20,
                },
            })

            -- Get completion capabilities for blink.cmp
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            -- Enhanced capabilities
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }

            -- Server configurations
            local servers = {
                -- Python Language Server
                pylsp = {
                    settings = {
                        pylsp = {
                            plugins = {
                                pycodestyle = { enabled = false },
                                mccabe = { enabled = false },
                                pyflakes = { enabled = false },
                                flake8 = {
                                    enabled = true,
                                    maxLineLength = 88,
                                },
                                black = { enabled = true },
                                isort = { enabled = true },
                                rope_autoimport = { enabled = true },
                            }
                        }
                    }
                },

                -- Rust Language Server
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                                loadOutDirsFromCheck = true,
                                buildScripts = { enable = true },
                            },
                            checkOnSave = {
                                allFeatures = true,
                                command = "clippy",
                                extraArgs = { "--no-deps" },
                            },
                            procMacro = { enable = true },
                        }
                    }
                },

                -- C/C++ Language Server
                clangd = {
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                    },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true,
                    },
                },

                -- Lua Language Server
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            diagnostics = { globals = { "vim", "use" } },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false,
                            },
                            telemetry = { enable = false },
                            hint = { enable = true },
                        },
                    },
                },
            }

            -- Setup servers manually (since mason-lspconfig might not be ready)
            for server_name, config in pairs(servers) do
                config.capabilities = capabilities

                -- Special handling for rust_analyzer
                if server_name == "rust_analyzer" then
                    config.on_attach = function(client, bufnr)
                        if client.server_capabilities.inlayHintProvider then
                            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                        end
                    end
                end

                lspconfig[server_name].setup(config)
            end

            -- Remove default key mappings to avoid conflicts
            local default_mappings = { "grn", "gra", "grr", "gri", "gO" }
            for _, mapping in ipairs(default_mappings) do
                pcall(vim.keymap.del, "n", mapping)
            end
        end,
    },
}
