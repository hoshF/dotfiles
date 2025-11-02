local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local get_visual = require("luasnip-helper-funcs").get_visual

return {
	s(
		{
			trig = "mat",
			snippetType = "autosnippet",
		},
		fmt(
			[[
\[{}\]
]],
			{
				i(1, ""),
			}
		)
	),
	s({ trig = "tt", dscr = "Expands 'tt' into '\texttt{}'" }, fmta("\\texttt{<>}", { d(1, get_visual) })),
	-- s(
	-- 	{ trig = "([^%a])ee", regTrig = true, wordTrig = false },
	-- 	fmta("<>e^{<>}", {
	-- 		f(function(_, snip)
	-- 			return snip.captures[1]
	-- 		end),
	-- 		d(1, get_visual),
	-- 	})
	-- ),
	-- s(
	-- 	{ trig = "([^%a])ff", regTrig = true, wordTrig = false },
	-- 	fmta([[<>\frac{<>}{<>}]], {
	-- 		f(function(_, snip)
	-- 			return snip.captures[1]
	-- 		end),
	-- 		i(1),
	-- 		i(2),
	-- 	})
	-- ),
}
