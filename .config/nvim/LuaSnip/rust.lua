local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("mr", {
    t("macro_rules! "),
    i(1, "name"),
    t({ " {", "    (" }),
    i(2),
    t({ ") => {", "        " }),
    i(3),
    t({ "", "    };", "}" }),
  }),
}
