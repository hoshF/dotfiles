return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	cmd = "Neotree",
	keys = {
		{ "<space>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
	},
	opts = {
		close_if_last_window = false,
		popup_border_style = "NC",
		enable_git_status = true,
		enable_diagnostics = true,
		open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
		open_files_using_relative_paths = false,
		sort_case_insensitive = false,
		sort_function = nil,
		default_component_configs = {
			container = {
				enable_character_fade = true,
			},
			indent = {
				indent_size = 2,
				padding = 1,
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				with_expanders = nil,
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "",
				provider = function(icon, node, state)
					if node.type == "file" or node.type == "terminal" then
						local success, web_devicons = pcall(require, "nvim-web-devicons")
						local name = node.type == "terminal" and "terminal" or node.name
						if success then
							local devicon, hl = web_devicons.get_icon(name)
							icon.text = devicon or icon.text
							icon.highlight = hl or icon.highlight
						end
					end
				end,
			},
			modified = {
				symbol = "[+]",
				highlight = "NeoTreeModified",
			},
			name = {
				trailing_slash = false,
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = {
					added = "", --"✚",
					modified = "", --"",
					deleted = "✖",
					renamed = "󰁕",
					untracked = "",
					ignored = "",
					unstaged = "",
					staged = "",
					conflict = "",
				},
			},
			file_size = {
				enabled = true,
				width = 12,
				required_width = 64,
			},
			type = {
				enabled = true,
				width = 10,
				required_width = 122,
			},
			last_modified = {
				enabled = true,
				width = 20,
				required_width = 88,
			},
			created = {
				enabled = true,
				width = 20,
				required_width = 110,
			},
			symlink_target = {
				enabled = false,
			},
		},
		commands = {},
		window = {
			position = "left",
			width = 25,
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = {
				-- Basic Navigation
				["<space>"] = { "toggle_node", nowait = false }, -- Expand/collapse folder
				["<2-LeftMouse>"] = "open", -- Double click to open
				["<cr>"] = "open", -- Enter: open file/folder
				["<esc>"] = "cancel", -- Escape: cancel operation
				["q"] = "close_window", -- q: close Neo-tree window

				-- Preview
				["P"] = {
					"toggle_preview", -- P: toggle preview window
					config = {
						use_float = true,
						use_snacks_image = true,
						use_image_nvim = true,
					},
				},
				["l"] = "focus_preview", -- l: focus on preview window

				-- Split Windows
				["S"] = "open_split", -- S: open in horizontal split
				["s"] = "open_vsplit", -- s: open in vertical split
				["t"] = "open_tabnew", -- t: open in new tab
				["w"] = "open_with_window_picker", -- w: pick window to open file

				-- Folder Operations
				["C"] = "close_all_nodes", -- C: close all folders
				["v"] = "expand_all_subnodes", -- v: expand all subfolders

				-- File Operations
				["a"] = {
					"add", -- a: add new file
					config = {
						show_path = "none",
					},
				},
				["A"] = "add_directory", -- A: add new directory
				["d"] = "delete", -- d: delete file/folder
				["r"] = "rename", -- r: rename file/folder
				["b"] = "rename_basename", -- b: rename only basename (keep extension)

				-- Copy/Paste
				["y"] = "copy_to_clipboard", -- y: copy (yank) to clipboard
				["x"] = "cut_to_clipboard", -- x: cut to clipboard
				["p"] = "paste_from_clipboard", -- p: paste from clipboard
				["c"] = "copy", -- c: copy file/folder
				["m"] = "move", -- m: move file/folder

				-- Utility
				["R"] = "refresh", -- R: refresh tree
				["?"] = "show_help", -- ?: show help
				["<"] = "prev_source", -- <: previous source (filesystem/buffers/git)
				[">"] = "next_source", -- >: next source
				["i"] = "show_file_details", -- i: show file info
			},
		},
		nesting_rules = {},
		filesystem = {
			filtered_items = {
				visible =  false,
				hide_dotfiles = true,
				hide_gitignored = true,
				hide_by_name = {},
				hide_by_pattern = {},
				always_show = {
					".gitignored",
				},
				always_show_by_pattern = {},
				never_show = {},
				never_show_by_pattern = {},
			},
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
			},
			group_empty_dirs = false,
			hijack_netrw_behavior = "open_default",
			use_libuv_file_watcher = false,
			window = {
				mappings = {
					-- Filesystem Navigation
					["<bs>"] = "navigate_up", -- Backspace: go to parent directory
					["."] = "set_root", -- .: set current folder as root
					["H"] = "toggle_hidden", -- H: toggle hidden files visibility

					-- Search & Filter
					["/"] = "fuzzy_finder", -- /: fuzzy search files
					["D"] = "fuzzy_finder_directory", -- D: fuzzy search directories
					["#"] = "fuzzy_sorter", -- #: fuzzy sort
					["f"] = "filter_on_submit", -- f: filter files
					["<c-x>"] = "clear_filter", -- Ctrl+x: clear filter

					-- Git Navigation
					["[g"] = "prev_git_modified", -- [g: previous git modified file
					["]g"] = "next_git_modified", -- ]g: next git modified file

					-- Sorting Options (press 'o' first, then press another key)
					["o"] = {
						"show_help", -- o: show ordering menu
						nowait = false,
						config = { title = "Order by", prefix_key = "o" },
					},
					["oc"] = { "order_by_created", nowait = false }, -- oc: sort by created time
					["od"] = { "order_by_diagnostics", nowait = false }, -- od: sort by diagnostics
					["og"] = { "order_by_git_status", nowait = false }, -- og: sort by git status
					["om"] = { "order_by_modified", nowait = false }, -- om: sort by modified time
					["on"] = { "order_by_name", nowait = false }, -- on: sort by name
					["os"] = { "order_by_size", nowait = false }, -- os: sort by size
					["ot"] = { "order_by_type", nowait = false }, -- ot: sort by type
				},
				fuzzy_finder_mappings = {
					["<down>"] = "move_cursor_down",
					["<C-n>"] = "move_cursor_down",
					["<up>"] = "move_cursor_up",
					["<C-p>"] = "move_cursor_up",
					["<esc>"] = "close",
					["<S-CR>"] = "close_keep_filter",
					["<C-CR>"] = "close_clear_filter",
					["<C-w>"] = { "<C-S-w>", raw = true },
					{
						n = {
							["j"] = "move_cursor_down",
							["k"] = "move_cursor_up",
							["<S-CR>"] = "close_keep_filter",
							["<C-CR>"] = "close_clear_filter",
							["<esc>"] = "close",
						},
					},
				},
			},

			commands = {},
		},
		buffers = {
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
			},
			group_empty_dirs = true,
			show_unloaded = true,
			window = {
				mappings = {
					-- Buffer Operations
					["d"] = "buffer_delete", -- d: delete buffer
					["bd"] = "buffer_delete", -- bd: delete buffer (alternative)
					["<bs>"] = "navigate_up", -- Backspace: navigate up
					["."] = "set_root", -- .: set root

					-- Sorting Options
					["o"] = {
						"show_help",
						nowait = false,
						config = { title = "Order by", prefix_key = "o" },
					},
					["oc"] = { "order_by_created", nowait = false },
					["od"] = { "order_by_diagnostics", nowait = false },
					["om"] = { "order_by_modified", nowait = false },
					["on"] = { "order_by_name", nowait = false },
					["os"] = { "order_by_size", nowait = false },
					["ot"] = { "order_by_type", nowait = false },
				},
			},
		},
		git_status = {
			window = {
				position = "float",
				mappings = {
					-- Git Operations
					["A"] = "git_add_all", -- A: git add all
					["gu"] = "git_unstage_file", -- gu: git unstage file
					["gU"] = "git_undo_last_commit", -- gU: git undo last commit
					["ga"] = "git_add_file", -- ga: git add file
					["gr"] = "git_revert_file", -- gr: git revert file
					["gc"] = "git_commit", -- gc: git commit
					["gp"] = "git_push", -- gp: git push
					["gg"] = "git_commit_and_push", -- gg: git commit and push

					-- Sorting Options
					["o"] = {
						"show_help",
						nowait = false,
						config = { title = "Order by", prefix_key = "o" },
					},
					["oc"] = { "order_by_created", nowait = false },
					["od"] = { "order_by_diagnostics", nowait = false },
					["om"] = { "order_by_modified", nowait = false },
					["on"] = { "order_by_name", nowait = false },
					["os"] = { "order_by_size", nowait = false },
					["ot"] = { "order_by_type", nowait = false },
				},
			},
		},
	},
}
