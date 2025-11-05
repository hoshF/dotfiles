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
    -- 中文学术模板
    s(
        {
            trig = "academic",
            dscr = "学术 LaTeX 模板",
            snippetType = "autosnippet",
        },
        fmta(
            [[
\documentclass[12pt,a4paper]{ctexart}

% -------------------------
% 字体设置
% -------------------------
\usepackage{fontspec}
\usepackage{xeCJK}
\setCJKmainfont{Source Han Serif SC}
\setCJKsansfont{Source Han Sans SC}
\setCJKmonofont{Source Han Mono SC}
\setmainfont{Times New Roman}

% -------------------------
% 数学字体
% -------------------------
\let\Bbbk\relax
\let\Zbar\relax
\usepackage{amsmath, amssymb, amsfonts}
\usepackage{newtxtext,newtxmath}

% -------------------------
% 数学扩展
% -------------------------
\usepackage{mathtools}

% -------------------------
% 页面布局
% -------------------------
\usepackage[a4paper,margin=2.5cm]{geometry}
\usepackage{setspace}
\onehalfspacing

% -------------------------
% 图表
% -------------------------
\usepackage{graphicx}
\usepackage{caption}
\usepackage{subcaption}
\usepackage{booktabs}
\usepackage{hyperref}
\hypersetup{colorlinks=true, linkcolor=blue, citecolor=blue, urlcolor=blue}

% -------------------------
% 代码
% -------------------------
\usepackage{listings}
\usepackage{xcolor}
\lstset{
    basicstyle=\ttfamily\small,
    keywordstyle=\color{blue}\bfseries,
    commentstyle=\color{gray}\itshape,
    stringstyle=\color{red},
    breaklines=true
}

\begin{document}
<>
\end{document}
]],
            {
                i(1, "这里输入正文"),
            }
        )
    ),
}

