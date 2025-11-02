local opts = { noremap = true, silent = true }
local map = vim.keymap.set
vim.o.updatetime = 300

-----------------
-- Normal mode --
-----------------
map("n", "<CR>", "o<Esc>k", opts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-----------------
-- Visual mode --
-----------------
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-----------------
-- Insert mode --
-----------------
-- map('i', 'jj', '<Esc>', opts)

-----------------
-- LSP keymap --
-----------------
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local lsp = vim.lsp
		local bufopts = { noremap = true, silent = false, buffer = args.buf }

		map("n", "gr", lsp.buf.references, bufopts)
		map("n", "gd", lsp.buf.definition, bufopts)
		map("n", "<space>r", lsp.buf.rename, bufopts)
		map("n", "K", lsp.buf.hover, bufopts)
		map("n", "<space>f", function()
			require("conform").format()
		end, bufopts)
		map("n", "<space>i", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, bufopts)
	end,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
	end,
})

-------------------
-- telescope map --
-------------------
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Commands" })

-----------------
-- LuaSnip opts--
-----------------
local luasnip = require("luasnip")
map({ "i", "s" }, "jk", function()
	if luasnip.jumpable(1) then
		luasnip.jump(1)
	end
end)

map({ "i", "s" }, "kj", function()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	end
end)

map({ "i", "s" }, "<C-j>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end)

map({ "i", "s" }, "<C-n>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(-1)
	end
end)

map("n", "<leader>ls", function()
	require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })
	vim.notify("LuaSnip snippets reloaded!")
end, { desc = "Reload LuaSnip snippets" })
