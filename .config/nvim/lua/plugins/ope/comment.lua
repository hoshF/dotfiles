return {
	"numToStr/Comment.nvim",
	event = "BufReadPost",
	config = function()
		local ft = require("Comment.ft")
		ft.json = "//%s"
		ft.yml = "#%s"
		ft.ini = ";%s"
		ft.service = "#%s"
		ft.timer = "#%s"
		require("Comment").setup({
			padding = true,
			sticky = true,
			ignore = "^$",
		})
	end,
}
