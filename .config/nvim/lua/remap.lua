local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-----------------
-- Normal mode --
-----------------
map("n", "<CR>", "o<Esc>k", opts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-----------------
-- Visual mode --
-----------------
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-----------------
-- Insert mode --
-----------------
-- map('i', 'jj', '<Esc>', opts)

-----------------
-- LSP keymap --
-----------------
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local lsp = vim.lsp
		local bufopts = { noremap = true, silent = false, buffer = args.buf }

		map("n", "gr", lsp.buf.references, bufopts)
		map("n", "gd", lsp.buf.definition, bufopts)
		map("n", "<space>r", lsp.buf.rename, bufopts)
		map("n", "K", lsp.buf.hover, bufopts)
		map("n", "<space>f", function()
			require("conform").format()
		end, bufopts)
		map("n", "<space>i", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, bufopts)
	end,
})

-------------------
-- telescope map --
-------------------
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Commands" })

-------------------
--   debug map   --
-------------------
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle all problems" })
map("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer problems" })
map("n", "<leader>xs", "<cmd>Trouble symbols toggle<cr>", { desc = "Code outline" })
map("n", "<leader>xr", "<cmd>Trouble lsp_references<cr>", { desc = "References" })
map("n", "<leader>xd", "<cmd>Trouble lsp_definitions<cr>", { desc = "Definitions" })

-------------------
--   debug map   --
-------------------
local function safe_require(module)
	local ok, result = pcall(require, module)
	return ok and result or nil
end

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyLoad",
	callback = function(event)
		if event.data == "nvim-dap" then
			local dap = require("dap")
			local dapui = safe_require("dapui")
			if dapui then
				map("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
			end
			map("n", "<F4>", dap.continue, { desc = " Start/Continue" })
			map("n", "<leader>di", dap.step_into, { desc = " Step into" })
			map("n", "<leader>do", dap.step_over, { desc = " Step over" })
			map("n", "<leader>dO", dap.step_out, { desc = " Step out" })
			map("n", "<leader>dq", dap.close, { desc = "DAP: Close session" })
			map("n", "<leader>dr", dap.restart_frame, { desc = "DAP: Restart frame" })
			map("n", "<leader>dQ", dap.terminate, { desc = " Terminate session" })
			map("n", "<leader>dc", function()
				if dap.session() then
					dap.run_to_cursor()
				else
					vim.notify("No active debug session. Starting debug session first.", vim.log.levels.INFO)
					dap.continue()
				end
			end, { desc = "DAP: Run to Cursor" })
			map("n", "<leader>dR", dap.repl.toggle, { desc = "DAP: Toggle REPL" })
			map("n", "<leader>dB", function()
				local input = vim.fn.input("Condition for breakpoint: ")
				dap.set_breakpoint(input)
			end, { desc = "DAP: Conditional Breakpoint" })
			map("n", "<leader>dD", dap.clear_breakpoints, { desc = "DAP: Clear Breakpoints" })
		end
	end,
})

-----------------
-- LuaSnip opts--
-----------------
local luasnip = require("luasnip")
map({ "i", "s" }, "jk", function()
	if luasnip.jumpable(1) then
		luasnip.jump(1)
	end
end)

map({ "i", "s" }, "kj", function()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	end
end)

map({ "i", "s" }, "<C-j>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end)

map({ "i", "s" }, "<C-n>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(-1)
	end
end)

map("n", "<leader>ls", function()
	require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })
	vim.notify("LuaSnip snippets reloaded!")
end, { desc = "Reload LuaSnip snippets" })
