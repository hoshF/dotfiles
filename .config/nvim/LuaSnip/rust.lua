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
		"derr",
		fmta('#[error("<>")]', {
			d(1, get_visual),
		})
	),

	s(
		"toma",
		fmt(
			[[
#[tokio::main] 
async fn main({}) -> Result<{}, Box<dyn std::error::Error>>{{
    {} 
}}
]],
			{
				i(1, ""),
				i(2, "()"),
				i(3, ""),
			}
		)
	),

	s(
		"tosp",
		fmt(
			[[
tokio::spawn(async move {{
    {} 
}});
]],
			{
				i(1, ""),
			}
		)
	),
}
