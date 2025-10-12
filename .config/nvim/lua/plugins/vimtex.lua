return {
	"lervag/vimtex",
	ft = { "tex" },
	init = function()
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_syntax_enabled = true
		vim.g.vimtex_view_forward_search_on_start = 1
		vim.g.vimtex_compiler_latexmk = { continuous = 1 }
		vim.g.vimtex_compiler_latexmk_engines = { ["_"] = "-xelatex" }
	end,
}
