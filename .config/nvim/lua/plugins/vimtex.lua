return {
	"lervag/vimtex",
	ft = { "tex" },
	init = function()
		vim.g.vimtex_view_method = "sioyek"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_syntax_enabled = true
		vim.g.vimtex_view_forward_search_on_start = 1
		vim.g.vimtex_compiler_latexmk = { continuous = 1 }
		vim.g.vimtex_compiler_latexmk_engines = { ["_"] = "-xelatex" }

		local os_name = vim.loop.os_uname().sysname
		if os_name == "Linux" then
			vim.g.vimtex_view_sioyek_exe = "/usr/bin/sioyek"
		elseif os_name == "Darwin" then
			vim.g.vimtex_view_sioyek_exe = "/Applications/sioyek.app/Contents/MacOS/sioyek"
		end
	end,
}
