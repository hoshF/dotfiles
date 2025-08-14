return {
	"jay-babu/mason-nvim-dap.nvim",
	lazy = true,
	config = function()
		require("mason-nvim-dap").setup({
			ensure_installed = {
				"codelldb",
				"debugpy",
				"delve",
			},
			automatic_installation = true,
		})
	end,
}
