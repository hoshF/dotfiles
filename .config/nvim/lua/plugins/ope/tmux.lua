return {
	"christoomey/vim-tmux-navigator",
	-- event = "BufReadPost",
	config = function()
		local modes = { "n", "i", "t" }

		local function tmux_navigate(direction)
			local mode = vim.api.nvim_get_mode().mode
			if mode == "t" then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", true)
			end
			vim.cmd("TmuxNavigate" .. direction)
		end

		local keymaps = {
			h = "Left",
			j = "Down",
			k = "Up",
			l = "Right",
			["\\"] = "Previous",
		}

		for key, dir in pairs(keymaps) do
			for _, mode in ipairs(modes) do
				vim.keymap.set(mode, "<C-" .. key .. ">", function()
					tmux_navigate(dir)
				end, { noremap = true, silent = true })
			end
		end
	end,
}
