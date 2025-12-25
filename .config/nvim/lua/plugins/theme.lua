return {
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			local themes = {
				{
					name = "nordic",
					colorscheme = "nordic",
				},
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
	{ "AlexvZyl/nordic.nvim", lazy = false },
}
