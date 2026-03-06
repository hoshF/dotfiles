return {
	{
		"andrewferrier/wrapping.nvim",
        event = "BufReadpost",
		opts = {
			softener = {
				markdown = false,

				tex = false,
			},
		},
	},
}
