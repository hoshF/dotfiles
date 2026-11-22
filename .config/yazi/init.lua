-- bunny.yazi: menu-driven directory hopping (keymap: ;)
require("bunny"):setup {
	hops = {
		{ key = "~", path = "~", desc = "Home" },
		{ key = "c", path = "~/.config", desc = "Config" },
		{ key = "C", path = "~/Cyber", desc = "Cyber" },
		{ key = "d", path = "~/Downloads", desc = "Downloads" },
		{ key = "D", path = "~/Documents", desc = "Documents" },
		{ key = "s", path = "~/Desktop", desc = "Desktop" },
		{ key = "p", path = "~/Pictures", desc = "Pictures" },
		{ key = "m", path = "~/Music", desc = "Music" },
		{ key = "v", path = "~/Videos", desc = "Videos" },
		{ key = "l", path = "~/.local/share", desc = "Local share" },
		{ key = "t", path = "/tmp", desc = "Temp" },
		{ key = "P", path = "~/Projects", desc = "Projects" },
	},

	desc_strategy = "path",
	ephemeral = true,
	tabs = true,
	notify = false,
	fuzzy_cmd = "fzf",
}
