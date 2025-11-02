vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.nrformats = { "bin", "hex", "alpha" }
vim.opt.mouse = "a"

-- Tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- UI config
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.showmode = false

-- Searching
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

local cc = {
	code = 100,
	doc = 80,
	wide = 120,
}

local ft_cc = {
	rust = cc.code,
	python = cc.code,
	lua = cc.code,
	go = cc.code,
	c = cc.wide,
	cpp = cc.wide,
	java = cc.wide,
	markdown = cc.code,
	tex = cc.doc,
	text = cc.doc,
}

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local col = ft_cc[args.match]
		if col then
			vim.opt_local.colorcolumn = tostring(col)
		else
			vim.opt_local.colorcolumn = ""
		end
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.cmd("highlight ColorColumn guibg=#3b4252")
	end,
})
