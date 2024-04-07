return {
	"nvim-lua/plenary.nvim",
	"ThePrimeagen/harpoon",
	enabled = true,
	lazy = false,
	opts = function(_, opts)
		opts = opts
		tabline_prefix = "#"
	end,
	--config = function()
	--	local Harpoon = require("harpoon")
	--	Harpoon.setup({
	--		tabline = true,
	--		tabline_prefix = "#",
	--		tabline_suffix = " ",
	--		global_settings = {
	--			-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
	--			save_on_toggle = true,

	--			-- saves the harpoon file upon every change. disabling is unrecommended.
	--			save_on_change = true,

	--			-- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
	--			enter_on_sendcmd = false,

	--			-- closes any tmux windows harpoon that harpoon creates when you close Neovim.
	--			tmux_autoclose_windows = false,

	--			-- filetypes that you want to prevent from adding to the harpoon list menu.
	--			excluded_filetypes = { "harpoon" },

	--			-- set marks specific to each git branch inside git repository
	--			mark_branch = false,

	--			-- enable tabline with harpoon marks
	--			-- tabline = true,
	--			-- tabline_prefix = " hellow  ",
	--			-- tabline_suffix = " world  ",
	--		},
	--		menu = {
	--			width = vim.api.nvim_win_get_width(0) - 30,
	--			height = vim.api.nvim_win_get_height(0) - 18,
	--		},
	--	})

	--	-- local harpoon = require("telescope").load_extension("harpoon")

	--	----------------------------- keymap for harpoon ---------------------------------
	--	vim.keymap.set("n", "<leader>hh", require("harpoon.mark").add_file, {})
	--	vim.keymap.set("n", "<leader>z", require("harpoon.ui").toggle_quick_menu)
	--	vim.keymap.set("n", "<C-j>", require("harpoon.ui").nav_prev) -- navigates to previous mark
	--	vim.keymap.set("n", "<C-k>", require("harpoon.ui").nav_next) -- navigates to next mark
	--	vim.keymap.set("n", "<C-q>", require("harpoon.ui").nav_next) -- navigates to next mark
	--	vim.keymap.set("n", "<leader>'", require("harpoon.ui").nav_next) -- navigates to next mark
	--	vim.keymap.set("n", "<leader>;", require("harpoon.ui").nav_prev) -- navigates to previous mark
	--	vim.keymap.set("n", "<leader>th", ":Telescope harpoon marks<CR>", {})
	--	----------------------------------------------------------------------------------

	--	----------------------------- Harpoon Theme customize ----------------------------
	--	vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
	--	vim.cmd("highlight! HarpoonActive guibg=NONE guifg=white")
	--	vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
	--	vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
	--	vim.cmd("highlight! TabLineFill guibg=#d9280d guifg=#d9280d")
	--	----------------------------------------------------------------------------------
	--end,
}
