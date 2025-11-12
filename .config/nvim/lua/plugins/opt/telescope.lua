return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope-frecency.nvim",
		"tami5/sqlite.lua",
	},
	keys = {
		{
			"<leader>ff",
			function()
				local ok = pcall(require("telescope.builtin").git_files)
				if not ok then
					require("telescope.builtin").find_files()
				end
			end,
			desc = "Find Files (git-aware)",
		},
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>fr", "<cmd>Telescope frecency<cr>", desc = "Frequent Files" },
		{ "<leader>fn", "<cmd>Telescope frecency workspace=nvim<cr>", desc = "Neovim config history" },
		{ "<leader>fp", "<cmd>Telescope frecency workspace=project<cr>", desc = "Project history" },
		{ "<leader>fcf", "<cmd>Telescope frecency workspace=conf<cr>", desc = "Config files history" },
	},

	config = function()
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				layout_strategy = "flex",
				scroll_strategy = "cycle",
				selection_strategy = "reset",
				winblend = 0,
				layout_config = {
					vertical = { mirror = true },
					center = { mirror = true },
				},
				sorting_strategy = "ascending",
				prompt_prefix = " λ ",
				selection_caret = "> ",
				path_display = { "smart" },
				dynamic_preview_title = true,
				file_ignore_patterns = {
					"target/",
					"build/",
					"%.o",
					"%.a",
					"%.out",
				},
				mappings = {
					i = {
						["<CR>"] = require("telescope.actions").select_default,
						["<C-v>"] = require("telescope.actions").select_vertical,
						["<C-x>"] = require("telescope.actions").select_horizontal,
						["<Tab>"] = require("telescope.actions").move_selection_next,
						["<S-Tab>"] = require("telescope.actions").move_selection_previous,
						["<C-h>"] = require("telescope.actions.layout").toggle_preview,
					},
					n = {
						["<CR>"] = require("telescope.actions").select_default,
						["<C-v>"] = require("telescope.actions").select_vertical,
						["<C-x>"] = require("telescope.actions").select_horizontal,
						["j"] = require("telescope.actions").move_selection_next,
						["k"] = require("telescope.actions").move_selection_previous,
					},
				},
			},

			pickers = {
				find_files = {
					theme = "dropdown",
					previewer = false,
					layout_config = { width = 0.7 },
				},
				buffers = {
					sort_mru = true,
					theme = "dropdown",
					previewer = false,
					mappings = {
						i = { ["<C-d>"] = require("telescope.actions").delete_buffer },
					},
				},
			},

			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
				frecency = {
					persistent_filter = false,
					show_scores = true,
					show_unindexed = true,
					ignore_patterns = { "*.git/*", "*/tmp/*", "*.foo" },
					workspaces = {
						conf = "/home/nore/.config",
						nvim = "/home/nore/.config/nvim",
						project = "/home/nore/Documents/Programing",
					},
				},
			},
		})

		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")
		pcall(telescope.load_extension, "frecency")
	end,
}
