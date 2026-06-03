return {
	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = {
			"saghen/blink.lib",
		},
		build = function()
			require("blink.cmp").build():wait(60000)
		end,
		opts = {
			appearance = {
				nerd_font_variant = "mono",
			},

			snippets = { preset = "luasnip" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			fuzzy = { implementation = "rust" },

			completion = {
				list = {
					selection = { preselect = false, auto_insert = true },
				},
				keyword = { range = "full" },
				menu = {
					draw = {
						treesitter = { "lsp" },
					},
				},
				trigger = {
					show_on_trigger_character = true,
					show_in_snippet = true,
				},
				documentation = {
					auto_show = true,
				},
			},

			signature = { enabled = true },

			keymap = {
				preset = "enter",
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
			},
		},
	},
}
