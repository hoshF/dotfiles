return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"jay-babu/mason-nvim-dap.nvim",
	},
	keys = {
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "DAP: Toggle Breakpoint",
		},
	},
	config = function()
		local dap = require("dap")

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.exepath("codelldb"),
				args = { "--port", "${port}" },
			},
		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					local cwd = vim.fn.getcwd()
					local debug_dir = cwd .. "/target/debug"

					if vim.fn.filereadable(cwd .. "/Cargo.toml") == 1 then
						local cargo_toml = vim.fn.readfile(cwd .. "/Cargo.toml")
						local project_name = nil
						for _, line in ipairs(cargo_toml) do
							local name_match = line:match('name%s*=%s*"([^"]+)"')
							if name_match then
								project_name = name_match
								break
							end
						end

						if project_name then
							local executable = debug_dir .. "/" .. project_name
							if vim.fn.filereadable(executable) == 1 then
								return executable
							end
						end

						if vim.fn.isdirectory(debug_dir) == 1 then
							local files = vim.fn.glob(debug_dir .. "/*", false, true)
							local executables = {}
							for _, file in ipairs(files) do
								if vim.fn.executable(file) == 1 and not file:match("%.") then
									table.insert(executables, file)
								end
							end

							if #executables == 1 then
								return executables[1]
							elseif #executables > 1 then
								local choice = vim.fn.inputlist(vim.tbl_map(function(exe, idx)
									return idx .. ". " .. vim.fn.fnamemodify(exe, ":t")
								end, executables))
								if choice > 0 and choice <= #executables then
									return executables[choice]
								end
							end
						end
					end

					local common_names = { "a.out", "main", "app", "program" }
					for _, name in ipairs(common_names) do
						local executable = cwd .. "/" .. name
						if vim.fn.executable(executable) == 1 then
							return executable
						end
					end

					return vim.fn.input("Path to executable: ", debug_dir .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
			{
				name = "Launch file (manual)",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}
		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp

		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = function()
					return "/usr/bin/python3"
				end,
			},
		}

		dap.adapters.python = {
			type = "executable",
			command = vim.fn.exepath("debugpy-adapter"),
		}
	end,
}
