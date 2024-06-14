return {
	"stevearc/oil.nvim",
	event = "VeryLazy",
	config = function()
		require("oil").setup({
			default_file_explorer = false,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			win_options = {
				wrap = true,
			},
		})
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
