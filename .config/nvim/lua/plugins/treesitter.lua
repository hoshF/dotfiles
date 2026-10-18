return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()

		require("nvim-treesitter").install({
			"bash",
			"lua",
			"rust",
			"c",
			"cpp",
			"python",
			"json",
			"markdown",
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "bash", "sh", "lua", "rust", "c", "cpp", "python", "json", "markdown" },
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
