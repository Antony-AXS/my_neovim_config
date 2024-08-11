return {
	"mbbill/undotree",
	event = "VeryLazy",
	config = function()
		vim.api.nvim_exec2(
			[[
                                if has("persistent_undo")
                                        let target_path = expand('~/.undodir')

                                           " create the directory and any parent directories
                                           " if the location does not exist.
                                           if !isdirectory(target_path)
                                               call mkdir(target_path, "p", 0700)
                                           endif

                                           let &undodir=target_path
                                           set undofile
                                endif

                                "if !exists('g:undotree_WindowLayout')
                                    let g:undotree_WindowLayout = 2
                                "endif
                        ]],
			{ output = false }
		)

		local window_fn = require("utils/fn")
		-- local undo_ascii = require("ascii")

		local undoTreeLayoutMemory = 2

		--------------------------------- keymap for undo-tree --------------------------------
		vim.keymap.set("n", "<leader>q", ":UndotreeToggle<CR>", { silent = true })
		vim.keymap.set("n", "<leader>a", ":UndotreeFocus<CR>", { silent = true })
		vim.keymap.set("n", "<leader>ut", function()
			if undoTreeLayoutMemory == 1 then
				vim.api.nvim_exec2("let g:undotree_WindowLayout = 2", { output = false })
				undoTreeLayoutMemory = 2
			elseif undoTreeLayoutMemory == 2 then
				vim.api.nvim_exec2("let g:undotree_WindowLayout = 1", { output = false })
				undoTreeLayoutMemory = 1
			end
		end, {})
		vim.keymap.set("n", "<leader>ur", function()
			local message
			local shell_list = {
				["cmd.exe"] = "del /Q %HOMEPATH%\\.undodir\\*",
				["/bin/bash"] = "rm ~/.undodir/* -vrf",
			}

			local command = shell_list[vim.o.shell]
			local response = vim.fn.system(command)

			if response:match("[a-zA-Z]") ~= nil then
				message = "REMOVED ALL UNDO FILES\n" .. response
			else
				message = "no files to remove from undo-directory"
			end
			vim.notify(message)
		end, {})
		vim.keymap.set("n", "<leader>uf", function()
			local function split_string(input_str)
				local i = 1
				local P = {}
				table.insert(P, "All Undodir Files Removed !!!")
				table.insert(P, " ")
				table.insert(P, "list of all files removed:")

				for line in input_str:gmatch("([^\n]+)") do
					table.insert(P, i .. "." .. " " .. line)
					i = i + 1
				end
				return P
			end

			local shell_list = {
				["cmd.exe"] = "del /Q %HOMEPATH%\\.undodir\\*",
				["/bin/bash"] = "rm ~/.undodir/* -vrf",
			}

			local command = shell_list[vim.o.shell]
			local input_str = vim.fn.system(command)

			if input_str:match("[a-zA-Z]") == nil then
				local message = "no files to remove from undo-directory"
				vim.notify(message)
				return 1
			end

			local content = split_string(input_str)
			window_fn.create_window_with_title("UndoTree", content)
		end, {})
		---------------------------------------------------------------------------------------
	end,
}
