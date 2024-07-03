return {
	"echasnovski/mini.indentscope",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		draw = {
			delay = 0,
			animation = function()
				return 0
			end,
		},
		options = { border = "top", try_as_border = true },
		symbol = "▏",
	},
	config = function(_, opts)
		require("mini.indentscope").setup(opts)

		-- Disable for certain filetypes
		vim.api.nvim_create_autocmd({ "FileType" }, {
			desc = "Disable indentscope for certain filetypes",
			callback = function()
				local ignore_filetypes = {
					"aerial",
					"dashboard",
					"help",
					"lazy",
					"leetcode.nvim",
					"mason",
					"neo-tree",
					"NvimTree",
					"neogitstatus",
					"notify",
					"startify",
					"DiffviewFiles",
					"fugitiveblame",
					"toggleterm",
					"Trouble",
					"undotree",
					"lazygit",
					"json",
					"text",
					"txt",
				}
				if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
					vim.b.miniindentscope_disable = true
				end
			end,
		})
		require("mini.indentscope").setup({})
	end,
}
