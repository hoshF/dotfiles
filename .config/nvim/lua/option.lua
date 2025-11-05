-- General
vim.opt.clipboard = "unnamedplus"            -- use system clipboard
vim.opt.mouse = "a"                           -- enable mouse support
vim.opt.lazyredraw = true                     -- do not redraw while executing macros
vim.opt.updatetime = 300                      -- faster completion (ms)
vim.opt.timeoutlen = 300                      -- keymap timeout (ms)
vim.opt.swapfile = false                      -- disable swapfile
vim.opt.backup = false                        -- disable backup
vim.opt.writebackup = false                   -- disable write backup

-- Tabs and Indentation
vim.opt.tabstop = 4                           -- number of spaces that a <Tab> counts for
vim.opt.softtabstop = 4                       -- number of spaces for editing
vim.opt.shiftwidth = 4                        -- number of spaces to use for autoindent
vim.opt.expandtab = true                       -- convert tabs to spaces

-- UI
vim.opt.number = true                          -- show line numbers
vim.opt.relativenumber = true                  -- show relative line numbers
vim.opt.cursorline = true                      -- highlight current line
vim.opt.splitbelow = true                      -- new horizontal splits go below
vim.opt.splitright = true                      -- new vertical splits go right
vim.opt.termguicolors = true                   -- enable 24-bit RGB colors
vim.opt.showmode = false                       -- do not show mode (handled by statusline)

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- completion options

-- Numbers & CTRL-A/X
vim.opt.nrformats = { "bin", "hex", "alpha" } -- number formats for CTRL-A/CTRL-X

-- Searching
vim.opt.incsearch = true                       -- incremental search
vim.opt.hlsearch = false                       -- do not highlight search matches
vim.opt.ignorecase = true                      -- ignore case when searching
vim.opt.smartcase = true                       -- override ignorecase if search has uppercase

