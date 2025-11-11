local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- Normal mode
map("n", "<CR>", "o<Esc>k", opts)

-- map("n", "<C-h>", "<C-w>h", opts)
-- map("n", "<C-j>", "<C-w>j", opts)
-- map("n", "<C-k>", "<C-w>k", opts)
-- map("n", "<C-l>", "<C-w>l", opts)

map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Visual mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Insert mode
-- map('i', 'jj', '<Esc>', opts)

-- LSP keymap
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local lsp = vim.lsp
		local bufopts = { noremap = true, silent = false, buffer = args.buf }

		map("n", "gr", lsp.buf.references, bufopts)
		map("n", "gd", lsp.buf.definition, bufopts)
		map("n", "<space>r", lsp.buf.rename, bufopts)
		map("n", "K", lsp.buf.hover, bufopts)
			map("n", "<space>i", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, bufopts)
	end,
})
