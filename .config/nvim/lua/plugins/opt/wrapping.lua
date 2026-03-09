return {
	{
		"andrewferrier/wrapping.nvim",
        event = "BufReadPost",
		opts = {
			softener = {
				markdown = false,
				tex = false,
			},
		},
	},
}
