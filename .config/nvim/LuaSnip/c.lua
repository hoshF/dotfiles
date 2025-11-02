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
		"std",
		fmt(
			[[
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
{}

int main(int argc, char *argv[]) {{
    {}
    return 0;
}}
]],
			{
				i(1, ""),
				i(2, ""),
			}
		)
	),

	s(
		{
			trig = "gcc",
			snippetType = "autosnippet",
		},
		fmt(
			[[
/*

{} 

*/
            ]],
			{
				i(1, ""),
			}
		)
	),
}
