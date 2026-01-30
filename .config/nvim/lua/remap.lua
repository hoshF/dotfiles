local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- Normal mode
map("n", "<CR>", "o<Esc>k", opts)

map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Visual mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Insert mode

-- Console mode
vim.keymap.set("n", "<leader>T", function()
	vim.cmd("split")
	vim.cmd("term")
	vim.cmd("startinsert")
end, { desc = "Terminal" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

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

-- LuaSnip
local luasnip = require("luasnip")
map({ "i", "s" }, "jk", function()
	if luasnip.jumpable(1) then
		luasnip.jump(1)
	else
		local keys = vim.api.nvim_replace_termcodes("<Right>", true, false, true)
		vim.api.nvim_feedkeys(keys, "n", true)
	end
end, { desc = "LuaSnip: Jump forward" })

map({ "i", "s" }, "kj", function()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	end
end, { desc = "LuaSnip: Jump backward" })

map({ "i", "s" }, "<C-j>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end, { desc = "LuaSnip: Next choice" })

map({ "i", "s" }, "<C-n>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(-1)
	end
end, { desc = "LuaSnip: Previous choice" })

map("n", "<leader>ls", function()
	require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })
	vim.notify("LuaSnip snippets reloaded!")
end, { desc = "Reload LuaSnip snippets" })
