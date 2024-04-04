local dadbod = require("plugins/dadbod")
local git = require("plugins/git_plugins")
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
		"folke/tokyonight.nvim",
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
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
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
	{
		"tpope/vim-commentary",
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	git,
	dadbod,
	-- {
	-- 	"BurntSushi/ripgrep",
	-- },
	-- {
	-- 	"glepnir/dbsession.nvim",
	-- 	cmd = { "SessionSave", "SessionDelete", "SessionLoad" },
	-- },
	-- {
	-- 	"petertriho/nvim-scrollbar",
	-- },
	-- {
	-- 	"mg979/vim-visual-multi",
	-- },
	-- {
	-- 	"kkharji/sqlite.lua",
	-- },
}
