-- Bookmarks plugin (dedukun/bookmarks.yazi) configuration.
-- Docs: ~/.config/yazi/plugins/bookmarks.yazi/README.md
--
-- Usage: m<key> save · `<key> jump · bd delete · bD delete all
require("bookmarks"):setup {
	-- Persist bookmarks across restarts (store in DDS state, ~/.local/state/yazi/.dds)
	persist = "all",

	-- `''` jumps back to the last visited directory (persisted too)
	last_directory = { enable = true, persist = true, mode = "dir" },

	-- Bookmark the current directory instead of the hovered file
	file_pick_mode = "parent",

	-- Show the available keys (and which are taken) when saving with `m`
	show_keys = true,

	notify = { enable = true, timeout = 1 },
}
