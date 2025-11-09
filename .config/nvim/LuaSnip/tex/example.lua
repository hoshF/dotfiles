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
  -- 主学术模板片段
  s(
    {
      trig = "academic",
      dscr = "完整的 LaTeX 学术论文模板",
      snippetType = "autosnippet",
    },
    fmta(
      [[
% !TEX program = xelatex
\documentclass[12pt, a4paper]{article}

% Chinese support
\usepackage{xeCJK}
\setCJKmainfont{Source Han Serif CN}[
    BoldFont=Source Han Serif CN Bold,
    ItalicFont=Source Han Serif CN
]
\setCJKsansfont{Source Han Sans CN}
\setCJKmonofont{Noto Sans Mono CJK SC}

% Math
\usepackage{amsmath, amssymb, amsthm, mathtools}

% Theorem environments
\newtheorem{theorem}{定理}[section]
\newtheorem{lemma}[theorem]{引理}
\newtheorem{corollary}[theorem]{推论}
\newtheorem{proposition}[theorem]{命题}
\newtheorem{definition}{定义}[section]
\newtheorem{example}{例}[section]
\newtheorem{remark}{注}[section]

% Figures & tables
\usepackage{graphicx, float, subfigure, caption, booktabs}
\captionsetup[figure]{labelfont=bf, name=图}
\captionsetup[table]{labelfont=bf, name=表}

% Page layout
\usepackage[top=2.5cm, bottom=2.5cm, left=3cm, right=3cm]{geometry}
\usepackage{setspace}
\onehalfspacing
\usepackage{indentfirst}
\setlength{\parindent}{2em}

% Hyperlinks
\usepackage{hyperref}
\hypersetup{colorlinks=true, linkcolor=black, citecolor=blue, urlcolor=blue}

% Code
\usepackage{listings, xcolor}
\lstset{
    basicstyle=\ttfamily\small,
    keywordstyle=\color{blue},
    commentstyle=\color{gray},
    stringstyle=\color{red},
    numbers=left,
    numberstyle=\tiny\color{gray},
    frame=single,
    breaklines=true
}

% Title
\title{<title>}
\author{<author>}
\date{\today}

\begin{document}

\maketitle

\begin{abstract}
<abstract>
\end{abstract}

\tableofcontents
\newpage

\section
<section1>

\end{document}
]],
      {
        title = i(1, "论文标题"),
        author = i(2, "作者姓名"),
        abstract = i(3, "这是摘要部分"),
        section1 = i(4, "这是引言部分"),
      }
    )
  ),

  -- 数学环境片段
  s(
    { trig = "thm", dscr = "定理环境" },
    fmta(
      [[
\begin{theorem}[<title>]
<content>
\end{theorem}
]],
      {
        title = i(1, "定理名称"),
        content = i(2),
      }
    )
  ),

  s(
    { trig = "def", dscr = "定义环境" },
    fmta(
      [[
\begin{definition}[<title>]
<content>
\end{definition}
]],
      {
        title = i(1, "定义名称"),
        content = i(2),
      }
    )
  ),

  s(
    { trig = "proof", dscr = "证明环境" },
    fmta(
      [[
\begin{proof}
<content>
\end{proof}
]],
      {
        content = i(1),
      }
    )
  ),

  -- 数学公式片段
  s(
    { trig = "align", dscr = "多行公式" },
    fmta(
      [[
\begin{align}
    <content>
\end{align}
]],
      {
        content = i(1),
      }
    )
  ),

  s(
    { trig = "matrix", dscr = "矩阵" },
    fmta(
      [[
\begin{<env>}
    <content>
\end{<env>}
]],
      {
        env = i(1, "pmatrix"),
        content = i(2),
      }
    )
  ),

  -- 图片和表格片段
  s(
    { trig = "fig", dscr = "图片环境" },
    fmta(
      [[
\begin{figure}[<position>]
    \centering
    \includegraphics[width=<width>\textwidth]{<filename>}
    \caption{<caption>}
    \label{fig:<label>}
\end{figure}
]],
      {
        position = i(1, "H"),
        width = i(2, "0.6"),
        filename = i(3, "example-image"),
        caption = i(4, "图片标题"),
        label = i(5, "label"),
      }
    )
  ),

  s(
    { trig = "tab", dscr = "表格环境" },
    fmta(
      [[
\begin{table}[<position>]
    \centering
    \caption{<caption>}
    \label{tab:<label>}
    \begin{tabular}{<alignment>}
        \toprule
        <header>
        \midrule
        <content>
        \bottomrule
    \end{tabular}
\end{table}
]],
      {
        position = i(1, "H"),
        caption = i(2, "表格标题"),
        label = i(3, "label"),
        alignment = i(4, "lccc"),
        header = i(5, "\\textbf{列1} & \\textbf{列2} & \\textbf{列3} \\\\"),
        content = i(6, "数据1 & 数据2 & 数据3 \\\\"),
      }
    )
  ),

  -- 代码环境片段
  s(
    { trig = "code", dscr = "代码环境" },
    fmta(
      [[
\begin{lstlisting}[language=<language>, caption=<caption>]
<code>
\end{lstlisting}
]],
      {
        language = i(1, "Python"),
        caption = i(2, "代码示例"),
        code = i(3),
      }
    )
  ),

  -- 参考文献条目
  s(
    { trig = "bib", dscr = "参考文献条目" },
    fmta(
      [[
\bibitem{<label>} 
<author>. <title>[<type>]. <journal>, <year>, <volume>(<issue>): <pages>.
]],
      {
        label = i(1, "ref1"),
        author = i(2, "作者"),
        title = i(3, "论文标题"),
        type = i(4, "J"),
        journal = i(5, "期刊名称"),
        year = i(6, "2024"),
        volume = i(7, "1"),
        issue = i(8, "1"),
        pages = i(9, "1-10"),
      }
    )
  ),

  -- 章节片段
  s(
    { trig = "sec", dscr = "章节" },
    fmta(
      [[
\section{<title>}
<content>
]],
      {
        title = i(1),
        content = i(2),
      }
    )
  ),

  s(
    { trig = "subsec", dscr = "子章节" },
    fmta(
      [[
\subsection{<title>}
<content>
]],
      {
        title = i(1),
        content = i(2),
      }
    )
  ),

  -- 引用片段
  s(
    { trig = "ref", dscr = "引用" },
    fmta(
      [[
\ref{<type>:<label>}
]],
      {
        type = i(1, "fig"),
        label = i(2, "label"),
      }
    )
  ),

  -- 简单的行内数学
  s(
    { trig = "mm", dscr = "行内数学", snippetType = "autosnippet" },
    fmta(
      [[$<content>$]],
      {
        content = i(1),
      }
    )
  ),

  -- 显示数学
  s(
    { trig = "dm", dscr = "显示数学", snippetType = "autosnippet" },
    fmta(
      [[\[
<content>
\] ]],
      {
        content = i(1),
      }
    )
  ),
}
