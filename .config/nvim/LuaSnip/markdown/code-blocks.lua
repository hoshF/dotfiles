local helpers = require('luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    s({trig="cc", snippetType = "autosnippet"},
      fmta(
        [[
        ```<>
        <>
        ```
      ]],
        {
          i(1),
          d(2, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    s({trig="html"},
      fmta(
        [[
        ```html
        <>
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    s({trig="phpp", snippetType="autosnippet"},
      fmt(
        [[
        ```php
        <?php
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    s({trig="pyy", snippetType="autosnippet"},
      fmt(
        [[
        ```python
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    s({trig="bc"},
      fmt(
        [[
        ```beancount
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    s({trig="shh", snippetType="autosnippet"},
      fmt(
        [[
        ```bash
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    s({trig="qq", snippetType="autosnippet"},
      fmt(
        [[
        ```sql
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    s({trig="jvs", snippetType="autosnippet"},
      fmt(
        [[
        ```javascript
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    s({trig="jss", snippetType="autosnippet"},
      fmta(
        [[
        ```json
        {
          <>
        }
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    s({trig="jsa", snippetType="autosnippet"},
      fmta(
        [[
        ```json
        [
          <>
        ]
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    s({trig="vuu", snippetType="autosnippet"},
      fmt(
        [[
        ```vue
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    s({trig="xx", snippetType="autosnippet"},
      fmt(
        [[
        ```txt
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
  }
