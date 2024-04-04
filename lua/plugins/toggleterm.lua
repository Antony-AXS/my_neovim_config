return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = [[<c-\>]],
			hide_numbers = true, -- hide the number column in toggleterm buffers
			shade_filetypes = {},
			highlights = {
				-- highlights which map to a highlight group name and a table of it's values
				-- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
				-- Normal = {
				-- 	guibg = "balck",
				-- },
				-- NormalFloat = {
				-- 	link = 'Normal'
				-- },
				-- FloatBorder = {
				-- 	guifg = "#0000ff",
				-- 	guibg = "#0000ff",
				-- },
			},
			shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true, -- whether or not the open mapping applies in insert mode
			terminal_mappings = true,
			persist_size = true,
			persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
			direction = "float",
			close_on_exit = true, -- close the terminal window when the process exit'
			shell = vim.o.shell,
			auto_scroll = true, -- automatically scroll to the bottom on terminal output
			-- This field is only relevant if direction is set to 'float'
			float_opts = {
				border = "curved", -- ... other options supported by win open
				-- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
				winblend = 0,
			},
		})
	end,
}
