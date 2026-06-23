local helpers = require("luasnip-helper-funcs")
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local tex = {}
tex.in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
	return not tex.in_mathzone()
end

return {
	s(
		{ trig = "ann", snippetType = "autosnippet" },
		fmta(
			[[
      \annotate{<>}{<>}
      ]],
			{
				i(1),
				d(2, get_visual),
			}
		)
	),
	s(
		{ trig = " RR", snippetType = "autosnippet", wordTrig = false },
		fmta(
			[[
      ~\ref{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	s(
		{ trig = "dcc", snippetType = "autosnippet" },
		fmta(
			[=[
        \documentclass[<>]{<>}
        ]=],
			{
				i(1, "a4paper"),
				i(2, "article"),
			}
		),
		{ condition = line_begin }
	),
	s(
		{ trig = "pack", snippetType = "autosnippet" },
		fmta(
			[[
        \usepackage{<>}
        ]],
			{
				d(1, get_visual),
			}
		),
		{ condition = line_begin }
	),
	s(
		{ trig = "inn", snippetType = "autosnippet" },
		fmta(
			[[
      \input{<><>}
      ]],
			{
				i(1, "~/dotfiles/config/latex/templates/"),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	s(
		{ trig = "lbl", snippetType = "autosnippet" },
		fmta(
			[[
      \label{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	s(
		{ trig = "hpp", snippetType = "autosnippet" },
		fmta(
			[[
      \hphantom{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	s(
		{ trig = "TODOO", snippetType = "autosnippet" },
		fmta([[\TODO{<>}]], {
			d(1, get_visual),
		})
	),
	s(
		{ trig = "nc" },
		fmta([[\newcommand{<>}{<>}]], {
			i(1),
			i(2),
		}),
		{ condition = line_begin }
	),
	s(
		{ trig = "sii", snippetType = "autosnippet" },
		fmta([[\si{<>}]], {
			i(1),
		})
	),
	s(
		{ trig = "qtt" },
		fmta([[\qty{<>}{<>}]], {
			i(1),
			i(2),
		})
	),
	s(
		{ trig = "url" },
		fmta([[\url{<>}]], {
			d(1, get_visual),
		})
	),
	s(
		{ trig = "LU", snippetType = "autosnippet" },
		fmta([[\href{<>}{<>}]], {
			d(1, get_visual),
			i(2),
		})
	),
	s(
		{ trig = "LL", snippetType = "autosnippet" },
		fmta([[\href{<>}{<>}]], {
			i(1),
			d(2, get_visual),
		})
	),
	s(
		{ trig = "hss", snippetType = "autosnippet" },
		fmta([[\hspace{<>}]], {
			d(1, get_visual),
		})
	),
	s(
		{ trig = "vss", snippetType = "autosnippet" },
		fmta([[\vspace{<>}]], {
			d(1, get_visual),
		})
	),
	s(
		{ trig = "h1", snippetType = "autosnippet" },
		fmta([[\section{<>}]], {
			d(1, get_visual),
		})
	),
	s(
		{ trig = "h2", snippetType = "autosnippet" },
		fmta([[\subsection{<>}]], {
			d(1, get_visual),
		})
	),
	s(
		{ trig = "h3", snippetType = "autosnippet" },
		fmta([[\subsubsection{<>}]], {
			d(1, get_visual),
		})
	),
	s(
		{ trig = "parr", snippetType = "autosnippet" },
		fmta([[\paragraph{<>}]], {
			d(1, get_visual),
		})
	),
}
