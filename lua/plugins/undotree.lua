return {
	"mbbill/undotree",
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

		local undoTreeLayoutMemory = 2

		------------------------------ keymap for undo-tree -------------------------------
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
		-----------------------------------------------------------------------------------
	end,
}
