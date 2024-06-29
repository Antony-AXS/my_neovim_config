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
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				event = "VeryLazy",
				config = function()
					require("nvim-treesitter.configs").setup({
						textobjects = {
							select = {
								enable = true,

								-- Automatically jump forward to textobj, similar to targets.vim
								lookahead = true,

								keymaps = {
									-- You can use the capture groups defined in textobjects.scm
									["af"] = "@function.outer",
									["if"] = "@function.inner",
									["ik"] = "@conditional.inner",
									["ak"] = "@conditional.outer",
									["ac"] = "@class.outer",
									-- You can optionally set descriptions to the mappings (used in the desc parameter of
									-- nvim_buf_set_keymap) which plugins like which-key display
									["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
									-- You can also use captures from other query groups like `locals.scm`
									["as"] = {
										query = "@scope",
										query_group = "locals",
										desc = "Select language scope",
									},
								},
								-- You can choose the select mode (default is charwise 'v')
								--
								-- Can also be a function which gets passed a table with the keys
								-- * query_string: eg '@function.inner'
								-- * method: eg 'v' or 'o'
								-- and should return the mode ('v', 'V', or '<c-v>') or a table
								-- mapping query_strings to modes.
								selection_modes = {
									["@parameter.outer"] = "v", -- charwise
									["@function.outer"] = "V", -- linewise
									["@class.outer"] = "<c-v>", -- blockwise
								},
								-- If you set this to `true` (default is `false`) then any textobject is
								-- extended to include preceding or succeeding whitespace. Succeeding
								-- whitespace has priority in order to act similarly to eg the built-in
								-- `ap`.
								--
								-- Can also be a function which gets passed a table with the keys
								-- * query_string: eg '@function.inner'
								-- * selection_mode: eg 'v'
								-- and should return true or false
								include_surrounding_whitespace = true,
							},
						},
					})
				end,
			},
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
		"folke/lazydev.nvim",
		event = "VeryLazy",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", event = "VeryLazy", lazy = true },
	{
		"hrsh7th/cmp-nvim-lsp",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
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
