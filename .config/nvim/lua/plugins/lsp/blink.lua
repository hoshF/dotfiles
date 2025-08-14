return {
	{
		"saghen/blink.cmp",
		version = "*",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
		},
		event = "VeryLazy",
		opts = {
			appearance = {
				nerd_font_variant = "mono",
			},

			sources = {
				default = { "lsp", "path", "buffer", "snippets" },
			},

			cmdline = {
				sources = function()
					local cmd_type = vim.fn.getcmdtype()
					if cmd_type == "/" then
						return { "buffer" }
					end
					if cmd_type == ":" then
						return { "cmdline" }
					end
					return {}
				end,
				completion = {
					list = {
						selection = { preselect = false, auto_insert = true },
					},
					menu = {
						auto_show = true,
					},
				},
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },

			completion = {
				list = {
					selection = { preselect = false, auto_insert = true },
				},
				keyword = { range = "prefix" },
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
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},
		},
		opts_extend = { "sources.default" },
	},
}
