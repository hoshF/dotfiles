local helpers = require("luasnip-helper-funcs")
local get_visual = helpers.get_visual

local tex = {}
tex.in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
	return not tex.in_mathzone()
end

return {
	s(
		{ trig = "([%w%)%]%}])'", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([%w%)%]%}]);", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([%w%)%]%}])__", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>^{<>}_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "sd", snippetType = "autosnippet", wordTrig = false },
		fmta("_{\\mathrm{<>}}", { d(1, get_visual) }),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = '([%w%)%]%}])"([%w])', regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([%w%)%]%}]):([%w])", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])ee", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>e^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([%a%)%]%}])00", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("0"),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([%a%)%]%}])11", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("-1"),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([%a%)%]%}])JJ", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("j"),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([%a%)%]%}])%+%+", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("+"),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([%a%)%]%}])CC", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("\\complement"),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([%a%)%]%}])%*%*", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("*"),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])vv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\vec{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])ue", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\unitvector_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])uv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\uvec{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])mt", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\mat{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])ff", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\frac{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])gg", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\ang{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])aa", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\abs{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%\\])sq", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\sqrt{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%\\])bnn", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\binom{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a%\\])ll", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\log_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])dV", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dvOne{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])dvv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dv{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])ddv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dvN{<>}{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
			i(3),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])pV", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\pdvOne{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])pvv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\pdv{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])ppv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\pdvN{<>}{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
			i(3),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])sM", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\sum_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])smm", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\sum_{<>}^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])intt", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\int_{<>}^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])intf", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\int_{\\infty}^{\\infty}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "([^%a])bb", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\boxed{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	s({ trig = "df", snippetType = "autosnippet", priority = 2000, snippetType = "autosnippet" }, {
		t("\\mathrm{d}"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "in1", snippetType = "autosnippet" }, {
		t("\\int"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "in2", snippetType = "autosnippet" }, {
		t("\\iint"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "in3", snippetType = "autosnippet" }, {
		t("\\iiint"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "oi1", snippetType = "autosnippet" }, {
		t("\\oint"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "oi2", snippetType = "autosnippet" }, {
		t("\\oiint"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "gdd", snippetType = "autosnippet" }, {
		t("\\grad "),
	}, { condition = tex.in_mathzone }),
	s({ trig = "cll", snippetType = "autosnippet" }, {
		t("\\curl "),
	}, { condition = tex.in_mathzone }),
	s({ trig = "DI", snippetType = "autosnippet" }, {
		t("\\div "),
	}, { condition = tex.in_mathzone }),
	s({ trig = "laa", snippetType = "autosnippet" }, {
		t("\\laplacian "),
	}, { condition = tex.in_mathzone }),
	s({ trig = "||", snippetType = "autosnippet" }, {
		t("\\parallel"),
	}),
	s({ trig = "cdd", snippetType = "autosnippet" }, {
		t("\\cdots"),
	}),
	s({ trig = "ldd", snippetType = "autosnippet" }, {
		t("\\ldots"),
	}),
	s({ trig = "eqq", snippetType = "autosnippet" }, {
		t("\\equiv "),
	}),
	s({ trig = "stm", snippetType = "autosnippet" }, {
		t("\\setminus "),
	}),
	s({ trig = "sbb", snippetType = "autosnippet" }, {
		t("\\subset "),
	}),
	s({ trig = "px", snippetType = "autosnippet" }, {
		t("\\approx "),
	}, { condition = tex.in_mathzone }),
	s({ trig = "pt", snippetType = "autosnippet" }, {
		t("\\propto "),
	}, { condition = tex.in_mathzone }),
	s({ trig = "::", snippetType = "autosnippet" }, {
		t("\\colon "),
	}),
	s({ trig = ">>", snippetType = "autosnippet" }, {
		t("\\implies "),
	}),
	s({ trig = ",.", snippetType = "autosnippet" }, {
		t("\\cdot "),
	}),
	s({ trig = "xx", snippetType = "autosnippet" }, {
		t("\\times "),
	}),
}
