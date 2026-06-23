require('luasnip').filetype_extend("markdown", {"hugo"})

local helpers = require('luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    s({trig="TODOO", snippetType="autosnippet"},
      {
        t("**TODO:** "),
      }
    ),
    s({trig="LL", wordTrig=true, snippetType="autosnippet"},
      fmta(
        [[[<>](<>)]],
        {
          d(1, get_visual),
          i(2),
        }
      )
    ),
    s({trig="LU", wordTrig=true, snippetType="autosnippet"},
      fmta(
        [[[<>](<>)]],
        {
          i(1),
          d(2, get_visual),
        }
      )
    ),
    s({trig="tbb", snippetType="autosnippet"},
      fmta(
        [[**<>**]],
        {
          d(1, get_visual),
        }
      )
    ),
    s({trig="tii", snippetType="autosnippet"},
      fmta(
        [[*<>*]],
        {
          d(1, get_visual),
        }
      )
    ),
    s({trig="uu", snippetType="autosnippet"},
      fmt(
        [[<u>{}</u>]],
        {
          d(1, get_visual),
        }
      )
    ),
    s({trig="  --", snippetType="autosnippet"},
      {t("- ")},
      {condition = line_begin}
    ),
  }
