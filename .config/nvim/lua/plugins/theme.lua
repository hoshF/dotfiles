return {
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			local themes = {
				{
					name = "gruvbox dark",
					colorscheme = "gruvbox",
					before = [[
      vim.opt.background = "dark"
    ]],
				},
				{
					name = "gruvbox light",
					colorscheme = "gruvbox",
					before = [[
      vim.opt.background = "light"
    ]],
				},
				{
					name = "oxocarbon dark",
					colorscheme = "oxocarbon",
					before = [[
      vim.opt.background = "dark"
    ]],
				},
				{
					name = "oxocarbon light",
					colorscheme = "oxocarbon",
					before = [[
      vim.opt.background = "light"
    ]],
				},
				{
					name = "nordic",
					colorscheme = "nordic",
				},
			}

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyDone",
				callback = function()
					require("themery").setup({ themes = themes })
				end,
			})
		end,
	},
	{ "ellisonleao/gruvbox.nvim", lazy = false },
	{ "nyoom-engineering/oxocarbon.nvim", lazy = false },
	{ "AlexvZyl/nordic.nvim", lazy = false },
}
