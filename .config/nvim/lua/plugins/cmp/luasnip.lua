return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	dependencies = { "rafamadriz/friendly-snippets" },
	build = "make install_jsregexp",
	event = "InsertEnter",
	config = function()
		local luasnip = require("luasnip")

		luasnip.config.set_config({
			history = false,
			updateevents = "TextChanged,TextChangedI",
			enable_autosnippets = true,
			store_selection_keys = "<Tab>",
			ext_opts = nil,
		})

		require("luasnip.loaders.from_vscode").lazy_load()
		local snippet_path = vim.fn.expand("~/.config/nvim/LuaSnip/")
		if vim.fn.isdirectory(snippet_path) == 1 then
			require("luasnip.loaders.from_lua").load({ paths = { snippet_path } })
		end

		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }
		map({ "i", "s" }, "jk", function()
			-- 【第一优先级】：只要有 Snippet 节点（比如 \frac{}{} 的括号），必须优先跳转！
			-- 这解决了你之前被困在 Snippet 里的问题。
			if luasnip.jumpable(1) then
				luasnip.jump(1)
				return
			end

			-- 【第二优先级】：如果不是 Snippet 节点，低头看看右边是不是闭合符号
			local col = vim.fn.col(".")
			local line = vim.fn.getline(".")
			local char = string.sub(line, col, col)

			-- 定义你需要跳过的符号边界（包含 LaTeX 最常用的 $）
			local closing_chars = {
				[")"] = true,
				["]"] = true,
				["}"] = true,
				['"'] = true,
				["'"] = true,
				["$"] = true,
			}

			if closing_chars[char] then
				-- 使用最底层 API 纯粹地发送一个 <Right>（向右箭头）按键，100% 稳定
				local keys = vim.api.nvim_replace_termcodes("<Right>", true, false, true)
				vim.api.nvim_feedkeys(keys, "n", true)
			end
			-- 如果既没节点，又不在括号边缘，jk 就什么也不做，防止日常打字误触
		end, { desc = "Smart Jump: LuaSnip first, then step over bracket" })

		map({ "i", "s" }, "kj", function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { desc = "LuaSnip: Jump backward" })

		map({ "i", "s" }, "<C-j>", function()
			if luasnip.choice_active() then
				luasnip.change_choice(1)
			end
		end, { desc = "LuaSnip: Next choice" })

		map({ "i", "s" }, "<C-n>", function()
			if luasnip.choice_active() then
				luasnip.change_choice(-1)
			end
		end, { desc = "LuaSnip: Previous choice" })

		map("n", "<leader>ls", function()
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })
			vim.notify("LuaSnip snippets reloaded!")
		end, { desc = "Reload LuaSnip snippets" })
	end,
}
