return {
    "lervag/vimtex",
    lazy = false,
    init = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_syntax_enabled = false
        vim.g.vimtex_compiler_latexmk_engines = {
            _ = 'xelatex'
        }
    end,
}
