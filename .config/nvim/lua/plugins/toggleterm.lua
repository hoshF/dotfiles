return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("toggleterm").setup({
			size = 60,
			open_mapping = [[<c-\>]],
			direction = "vertical",
			hide_numbers = true,
			shade_terminals = true,
			start_in_insert = true,
			close_on_exit = true,
			auto_scroll = true,
			on_open = function(term)
				local opts = { buffer = term.bufnr, noremap = true, silent = true }
				vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			end,
		})
	end,
}
