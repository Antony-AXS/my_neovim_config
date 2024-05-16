return {
	"mbbill/undotree",
	config = function()
		------------------------------ keymap for undo-tree -------------------------------
		vim.keymap.set("n", "<leader>q", ":UndotreeToggle<CR>", { silent = true })
		vim.keymap.set("n", "<leader>a", ":UndotreeFocus<CR>", { silent = true })
		-----------------------------------------------------------------------------------
	end,
}
