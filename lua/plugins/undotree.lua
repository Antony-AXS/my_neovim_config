return {
	"mbbill/undotree",
	config = function()
		------------------------------ keymap for undo-tree -------------------------------
		vim.keymap.set("n", "<leader>q", ":UndotreeToggle<CR>", {})
		vim.keymap.set("n", "<leader>a", ":UndotreeFocus<CR>", {})
		-----------------------------------------------------------------------------------
	end,
}
