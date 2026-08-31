vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.lazyredraw = true
vim.opt.updatetime = 300
vim.opt.textwidth = 0
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
-- inline cmdline completion (pum popup glitches with cmdheight=0)
vim.opt.wildoptions = "tagfile"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.showmode = false

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.nrformats = { "bin", "hex", "alpha" }

vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.textwidth = 72
		vim.opt_local.colorcolumn = "51,73"
	end,
})
