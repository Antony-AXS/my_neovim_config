return {
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		priority = 1000,
	},
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
		event = "VeryLazy",
		priority = 1000,
		opts = {},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- dependencies = {
		-- 	"nvim-treesitter/nvim-treesitter-textobjects",
		-- },
	},
	{
		"nvim-tree/nvim-web-devicons",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"williamboman/mason.nvim",
		lazy = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			auto_install = true,
		},
		lazy = true,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,
	},
	{
		"nvimtools/none-ls.nvim",
		lazy = true,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		lazy = true,
	},
	-- {
	-- 	"BurntSushi/ripgrep",
	-- },
	{
		"tpope/vim-fugitive",
	},
	{
		"nvim-lua/plenary.nvim",
		"ThePrimeagen/harpoon",
		lazy = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		main = "ibl",
		event = "VeryLazy",
		opts = {},
	},
	{
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
						"toggleterm",
						"Trouble",
						"undotree",
						"lazygit",
					}
					if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
						vim.b.miniindentscope_disable = true
					end
				end,
			})
		end,
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	-- {
	-- 	"glepnir/dbsession.nvim",
	-- 	cmd = { "SessionSave", "SessionDelete", "SessionLoad" },
	-- },
	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"lewis6991/gitsigns.nvim",
	},
	-- {
	-- 	"petertriho/nvim-scrollbar",
	-- },
	{
		"folke/tokyonight.nvim",
	},
	-- {
	-- 	"kkharji/sqlite.lua",
	-- },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
	},
	-- {
	-- 	"mg979/vim-visual-multi",
	-- },
	{
		"mbbill/undotree",
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},
	{
		"tpope/vim-dadbod",
		opt = true,
		requires = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"kristijanhusak/vim-dadbod-completion",
	},
	{
		"ThePrimeagen/git-worktree.nvim",
	},
	{
		"stevearc/oil.nvim",
	},
	{
		"tpope/vim-commentary",
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	-- {
	-- 	"NeogitOrg/neogit",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim", -- required
	-- 		"sindrets/diffview.nvim", -- optional - Diff integration

	-- 		-- Only one of these is needed, not both.
	-- 		"nvim-telescope/telescope.nvim", -- optional
	-- 		"ibhagwan/fzf-lua", -- optional
	-- 	},
	-- 	config = true,
	-- 	lazy = true,
	-- },
}
