local git = require("plugins/git")
local dadbod = require("plugins/dadbod")
local colorschemes = require("plugins/colorschemes")

return {
	{
		"nvim-telescope/telescope.nvim",
		-- tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "VeryLazy",
		dependencies = {
			"j-hui/fidget.nvim",
			opts = {},
			-- 	"nvim-treesitter/nvim-treesitter-textobjects",
			-- 	{ "RRethy/nvim-treesitter-endwise", cond = not locals.treesitter_dev }
		},
	},
	{
		"williamboman/mason.nvim",
		lazy = true,
		event = "VeryLazy",
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			auto_install = true,
		},
		dependencies = {
			"j-hui/fidget.nvim",
			opts = {},
			-- 	"nvim-treesitter/nvim-treesitter-textobjects",
		},
		lazy = true,
		event = "VeryLazy",
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"j-hui/fidget.nvim",
			opts = {},
		},
	},
	{
		"nvimtools/none-ls.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"j-hui/fidget.nvim",
			opts = {},
		},
	},
	{
		"hrsh7th/nvim-cmp", --  the completion plugin
		event = "VeryLazy",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		event = "VeryLazy",
	},
	{
		"hrsh7th/cmp-nvim-lua",
		event = "VeryLazy",
	},
	{
		"L3MON4D3/LuaSnip",
		event = "VeryLazy",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		build = "make install_jsregexp",
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

	git,
	dadbod,
	colorschemes,

	-- {
	-- 	"tpope/vim-commentary",
	-- },
	-- {
	-- 	"JoosepAlviste/nvim-ts-context-commentstring",
	-- },
	-- {
	-- 	"BurntSushi/ripgrep",
	-- },
	-- {
	-- 	"glepnir/dbsession.nvim",
	-- 	cmd = { "SessionSave", "SessionDelete", "SessionLoad" },
	-- },
	-- {
	-- 	"mg979/vim-visual-multi",
	-- },
	-- {
	-- 	"kkharji/sqlite.lua",
	-- },
}
