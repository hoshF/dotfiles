local opts = {
    noremap = true,
    silent = true,
}
local map = vim.keymap.set

-----------------
-- Normal mode --
-----------------
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

map('n', '<C-Up>', ':resize -2<CR>', opts)
map('n', '<C-Down>', ':resize +2<CR>', opts)
map('n', '<C-Left>', ':vertical resize -2<CR>', opts)
map('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-----------------
-- Visual mode --
-----------------
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-----------------
-- Insert mode --
-----------------
map('i', 'jj', '<Esc>', opts)

-----------------
-- LSP keymap --
-----------------
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local lsp = vim.lsp
        local bufopts = { noremap = true, silent = true, buffer = args.buf }

        map("n", "gr", lsp.buf.references, bufopts)
        map("n", "gd", lsp.buf.definition, bufopts)
        map("n", "<space>rn", lsp.buf.rename, bufopts)
        map("n", "K", lsp.buf.hover, bufopts)
        map("n", "<space>f", function()
            require("conform").format({ async = true, lsp_fallback = true })
        end, bufopts)
    end
})

-------------------
-- telescope map --
-------------------
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Commands" })

