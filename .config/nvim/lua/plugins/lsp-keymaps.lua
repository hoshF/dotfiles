return {
    {
        name = "lsp-keymaps",
        dir = vim.fn.stdpath("config"),
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    local bufnr = args.buf

                    -- Keymap options
                    local opts = { noremap = true, silent = true, buffer = bufnr }
                    local function map(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
                    end

                    -- === Navigation ===
                    map("n", "gd", "<cmd>Lspsaga goto_definition<CR>", "Go to Definition")
                    map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
                    map("n", "gp", "<cmd>Lspsaga peek_definition<CR>", "Peek Definition")
                    map("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>", "Go to Type Definition")
                    map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
                    map("n", "gr", "<cmd>Lspsaga finder<CR>", "Find References")

                    -- === Documentation ===
                    map("n", "K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
                    map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
                    map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")

                    -- === Code Actions ===
                    map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", "Code Action")
                    map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", "Rename Symbol")
                    map("n", "<leader>rf", "<cmd>Lspsaga rename ++project<CR>", "Rename in Project")

                    -- === Diagnostics ===
                    map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Previous Diagnostic")
                    map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic")
                    map("n", "[e", function()
                        require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
                    end, "Previous Error")
                    map("n", "]e", function()
                        require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
                    end, "Next Error")
                    map("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", "Show Line Diagnostics")
                    map("n", "<leader>E", "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show Cursor Diagnostics")
                    map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostic Quickfix")

                    -- === Workspace ===
                    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
                    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
                    map("n", "<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, "List Workspace Folders")

                    -- === Formatting ===
                    map({ "n", "v" }, "<leader>f", function()
                        local has_conform, conform = pcall(require, "conform")
                        if has_conform then
                            conform.format({ async = true, lsp_fallback = true })
                        else
                            vim.lsp.buf.format({ async = true })
                        end
                    end, "Format Document/Range")

                    -- === Outline and Symbols ===
                    map("n", "<leader>o", "<cmd>Lspsaga outline<CR>", "Toggle Outline")
                    map("n", "<leader>s", "<cmd>Lspsaga incoming_calls<CR>", "Incoming Calls")
                    map("n", "<leader>S", "<cmd>Lspsaga outgoing_calls<CR>", "Outgoing Calls")

                    -- === Toggle Features ===
                    map("n", "<leader>tl", function()
                        local current = vim.diagnostic.config().virtual_lines
                        vim.diagnostic.config({
                            virtual_lines = not current,
                            virtual_text = current
                        })
                    end, "Toggle LSP Lines")

                    map("n", "<leader>th", function()
                        if client and client.server_capabilities.inlayHintProvider then
                            vim.lsp.inlay_hint.enable(
                                not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
                                { bufnr = bufnr }
                            )
                        end
                    end, "Toggle Inlay Hints")

                    -- === Language-specific mappings ===
                    if client and client.name == "rust_analyzer" then
                        map("n", "<leader>cr", function()
                            vim.cmd("RustLsp runnables")
                        end, "Rust Runnables")
                        map("n", "<leader>ce", function()
                            vim.cmd("RustLsp expandMacro")
                        end, "Expand Macro")
                        map("n", "<leader>ch", function()
                            vim.cmd("RustLsp hover actions")
                        end, "Hover Actions")
                    end

                    -- === Document Highlighting ===
                    if client and client.server_capabilities.documentHighlightProvider then
                        local highlight_augroup = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = bufnr,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })
                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = bufnr,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end
                end,
            })
        end,
    },
}
