local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local helpers = require("luasnip-helper-funcs")
local get_visual = helpers.get_visual

return {
	s("doc", {
		t("\\documentclass["),
		c(1, {
			t("a4paper, 12pt"),
			t("a4paper, 11pt"),
			t("letterpaper, 12pt"),
			t("b5paper, 10pt"),
		}),
		t("]{"),
		c(2, {
			t("article"),
			t("report"),
			t("book"),
			t("ctexart"),
			t("ctexrep"),
			t("ctexbook"),
		}),
		t("}"),
		t({ "", "", "\\begin{document}", "" }),
		i(3, "% input here"),
		t({ "", "" }),
		i(4, ""),
		t({ "", "", "\\end{document}" }),
	}),

	s("tit", {
		t("\\title{"),
		i(1, "Document"),
		t("}"),
		t({ "", "\\author{" }),
		i(2, "Nore"),
		t({ "}", "\\date{" }),
		i(3, "\\today"),
		t({ "}", "\\maketitle", "" }),
	}),
	s(
		{ trig = "hr", dscr = "The hyperref package's href{}{} command (for url links)" },
		fmta([[\href{<>}{<>}]], {
			i(1, "url"),
			i(2, "display name"),
		})
	),
}
