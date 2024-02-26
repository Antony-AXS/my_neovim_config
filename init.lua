local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
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
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"nvimtools/none-ls.nvim",
	},
	{
		"hrsh7th/nvim-cmp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"BurntSushi/ripgrep",
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"nvim-lua/plenary.nvim",
		"ThePrimeagen/harpoon",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{
		"echasnovski/mini.indentscope",
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
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
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
	{
		"kkharji/sqlite.lua",
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
		"mg979/vim-visual-multi",
	},
	{
		"mbbill/undotree",
	},
	-- {
	-- 	"3rd/image.nvim",
	-- },
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		-- add any options here
	-- 	},
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- },
	{
		-- amongst your other plugins
		{ "akinsho/toggleterm.nvim", version = "*", config = true },
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
}

local opts = {}

require("lazy").setup(plugins, opts)

local builtin = require("telescope.builtin")

local treesitter_configs = require("nvim-treesitter.configs")

treesitter_configs.setup({
	ensure_installed = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"elixir",
		"heex",
		"javascript",
		"typescript",
		"html",
		"python",
		"json",
		"css",
		"rust",
		"sql",
	},
	auto_install = true,
	sync_install = false,

	highlight = {
		enable = true,
		-- custom_captures = {
		-- 	-- Highlight the @foo.bar capture group with the "Identifier" highlight group.
		-- 	["foo.bar"] = "Identifier",
		-- },
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
})

package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

local ascii = require("ascii")

require("dashboard").setup({
	theme = "hyper",
	config = {
		header = ascii.header_2,
		packages = { enable = true }, -- show how many plugins neovim loaded
		-- limit how many projects list, action when you press key or enter it will run this action.
		-- action can be a functino type, e.g.
		-- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
		project = { enable = true, limit = 3, icon = "your icon", label = "", action = "Telescope find_files cwd=" },
		mru = { limit = 6, icon = "your icon", label = "", cwd_only = false },
	},
})

-- local highlight = {
-- 	"CursorColumn",
-- 	"Whitespace",
-- }

require("ibl").setup({
	-- indent = { highlight = highlight },
	scope = { enabled = false },
	exclude = {
		filetypes = {
			"help",
			"alpha",
			"dashboard",
			"neo-tree",
			"Trouble",
			"trouble",
			"lazy",
			"mason",
			"notify",
			"toggleterm",
			"lazyterm",
		},
	},
})

-- local colors = require("tokyonight.colors").setup()

-- require("scrollbar").setup({
-- 	show = true,
-- 	show_in_active_only = true,
-- 	set_highlights = true,
-- 	folds = 10000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
-- 	max_lines = false, -- disables if no. of lines in buffer exceeds this
-- 	hide_if_all_visible = false, -- Hides everything if all lines are visible
-- 	throttle_ms = 80,
-- 	handle = {
-- 		-- text = "",
-- 		color = colors.grey,
-- 		blend = 9,
-- 		-- highlight = "CursorColumn",
-- 		hide_if_all_visible = false, -- Hides handle if all lines are visible
-- 	},
-- 	marks = {
-- 		Cursor = {
-- 			text = "•",
-- 			priority = 0,
-- 			gui = nil,
-- 			color = nil,
-- 			cterm = nil,
-- 			color_nr = nil, -- cterm
-- 			highlight = nil,
-- 		},
-- 		-- Search = { color = colors.orange },
-- 		Error = { color = colors.error, priority = 1 },
-- 		-- Warn = { color = colors.warning },
-- 		-- Info = { color = colors.info },
-- 		-- Hint = { color = colors.hint, priority = 2 },
-- 		-- Misc = { color = colors.purple },
-- 		GitAdd = {
-- 			text = "+",
-- 			priority = 1,
-- 			gui = nil,
-- 			color = "green",
-- 			cterm = nil,
-- 			color_nr = nil, -- cterm
-- 			highlight = "GitSignsAdd",
-- 		},
-- 		GitChange = {
-- 			text = "~",
-- 			priority = 1,
-- 			gui = nil,
-- 			color = "green",
-- 			cterm = nil,
-- 			color_nr = nil, -- cterm
-- 			highlight = "GitSignsChange",
-- 		},
-- 		GitDelete = {
-- 			text = "▁",
-- 			priority = 1,
-- 			gui = nil,
-- 			color = "green",
-- 			cterm = nil,
-- 			color_nr = nil, -- cterm
-- 			highlight = "GitSignsDelete",
-- 		},
-- 	},
-- 	excluded_buftypes = {
-- 		"terminal",
-- 		"lazygit.nvim",
-- 		"lazygit_floating_window_winblend",
-- 		"telescope",
-- 		"TelescopePrompt",
-- 	},
-- 	excluded_filetypes = {
-- 		"cmp_docs",
-- 		"cmp_menu",
-- 		"noice",
-- 		"prompt",
-- 		"telescope",
-- 		"TelescopePrompt",
-- 		"TelescopePromptNormal",
-- 		"TelescopeBorder",
-- 		"TelescopeNormal",
-- 		"dashboard",
-- 		"neo-tree",
-- 		"lazygit_floating_window",
-- 		"harpoon",
-- 		"lazy",
-- 		"mason",
-- 		"fugitive",
-- 		"LazyGit.nvim",
-- 		"LazyGit",
-- 	},
-- 	autocmd = {
-- 		render = {
-- 			"BufWinEnter",
-- 			"TabEnter",
-- 			"TermEnter",
-- 			"WinEnter",
-- 			"CmdwinLeave",
-- 			"TextChanged",
-- 			"VimResized",
-- 			"WinScrolled",
-- 		},
-- 		clear = {
-- 			"BufWinLeave",
-- 			"TabLeave",
-- 			"TermLeave",
-- 			"WinLeave",
-- 		},
-- 	},
-- 	handlers = {
-- 		-- cursor = true,
-- 		-- diagnostic = true,
-- 		gitsigns = true, -- Requires gitsigns
-- 		-- handle = true,
-- 		search = false, -- Requires hlslens
-- 		ale = false, -- Requires ALE
-- 	},
-- })

require("telescope").load_extension("lazygit")

require("harpoon").setup({
	tabline = true,
	tabline_prefix = " $ ",
	tabline_suffix = " ",
	global_settings = {
		-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
		save_on_toggle = true,

		-- saves the harpoon file upon every change. disabling is unrecommended.
		save_on_change = true,

		-- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
		enter_on_sendcmd = false,

		-- closes any tmux windows harpoon that harpoon creates when you close Neovim.
		tmux_autoclose_windows = false,

		-- filetypes that you want to prevent from adding to the harpoon list menu.
		excluded_filetypes = { "harpoon" },

		-- set marks specific to each git branch inside git repository
		mark_branch = false,

		-- enable tabline with harpoon marks
		tabline = true,
		tabline_prefix = " hellow  ",
		tabline_suffix = " world  ",
	},
	menu = {
		width = vim.api.nvim_win_get_width(0) - 30,
		height = vim.api.nvim_win_get_height(0) - 18,
	},
})

local positive_look_behind = function(opts)
	local cmd = ".,+22s/\\(" .. tostring(vim.fn.getreg("0")) .. "\\)\\@<=.*/" .. opts.args .. "/"
	print(cmd)
	vim.api.nvim_command(cmd)
	return 0
end
local TshiftToggleConst = "2"
local shift_theme = function(opts)
	if opts.args == "sol" then
		vim.cmd.colorscheme("solarized-osaka")
	elseif opts.args == "cat" then
		vim.cmd.colorscheme("catppuccin")
	elseif opts.args == "Toggle" then
		if TshiftToggleConst == "1" then
			TshiftToggleConst = "2"
			vim.api.nvim_command("colorscheme catppuccin")
		elseif TshiftToggleConst == "2" then
			TshiftToggleConst = "1"
			vim.api.nvim_command("colorscheme solarized-osaka")
		end
	end
end

vim.api.nvim_create_user_command("Pchange", positive_look_behind, { nargs = "?" })
vim.api.nvim_create_user_command("Tshift", shift_theme, { nargs = "?" })
vim.keymap.set("n", "<leader>cs", ":Tshift Toggle<CR>", {})

local NeoTreeGitStatus = function(opts)
	local cmd = "Neotree float git_status git_base=" .. opts.args
	print(cmd)
	vim.api.nvim_command(cmd)
	return 0
end

vim.api.nvim_create_user_command("Ngs", NeoTreeGitStatus, { nargs = "?" })
-- local subscribe = vim.api.nvim_subscribe('NeoTree')
-- print("SUBSCRIBED------------------>>>>>>>>>>>>>>", vim.api.nvim_call_function('Neotree', {}))

local harpoon = require("telescope").load_extension("harpoon")

vim.keymap.set("n", "<leader>lb", positive_look_behind)
----------------------------- Harpoon Theme customize -----------------------------
vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
vim.cmd("highlight! HarpoonActive guibg=NONE guifg=white")
vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
vim.cmd("highlight! TabLineFill guibg=#d9280d guifg=#d9280d")
----------------------------------------------------------------------------------

------------------------------ keymap for telescope ------------------------------
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fs", builtin.search_history, {})
vim.keymap.set("n", "<leader>fe", builtin.resume, {})
vim.keymap.set("n", "<leader>fp", builtin.pickers, {})
vim.keymap.set("n", "<leader>fr", ":Telescope live_grep theme=dropdown<CR>", {})
vim.keymap.set("n", "<leader>fi", ":Telescope find_files hidden=true<CR>", {})
vim.keymap.set("n", "<leader>fa", ":Telescope find_files find_command=rg,--ignore,--hidden,--files,-u<CR>", {})
----------------------------------------------------------------------------------

------------------------------- keymap for neo-tree -------------------------------
vim.keymap.set("n", "<leader>p", ":Neotree<CR>", {})
vim.keymap.set("n", "<leader>ng", ":Neotree float git_status<CR>", {})
vim.keymap.set("n", "<C-t>", ":Neotree  source=filesystem reveal left toggle=true<CR>", {})
vim.keymap.set(
	"n",
	"<leader>nb",
	":Neotree float git_status git_base=" .. vim.fn.system("git branch --show-current") .. "<CR>",
	{}
)
-----------------------------------------------------------------------------------

------------------------------ keymap for undo-tree -------------------------------
vim.keymap.set("n", "<leader>q", ":UndotreeToggle<CR>", {})
vim.keymap.set("n", "<leader>a", ":UndotreeFocus<CR>", {})
-----------------------------------------------------------------------------------

------------------------------ keymap for lsp-buffer ------------------------------
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
-----------------------------------------------------------------------------------

----------------------------- keymap for none-ls ---------------------------------
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
vim.keymap.set("v", "<Leader>1f", vim.lsp.buf.format, {})
----------------------------------------------------------------------------------

----------------------------- keymap for harpoon ---------------------------------
vim.keymap.set("n", "<leader>hh", require("harpoon.mark").add_file, {})
vim.keymap.set("n", "<leader>z", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "<leader>'", require("harpoon.ui").nav_next) -- navigates to next mark
vim.keymap.set("n", "<leader>;", require("harpoon.ui").nav_prev) -- navigates to previous mark
vim.keymap.set("n", "<leader>th", ":Telescope harpoon marks<CR>", {})
----------------------------------------------------------------------------------

----------------------------- keymap for toggle-term -----------------------------
vim.keymap.set("n", "<leader>cf", ":ToggleTerm direction=float size=20<CR>", {})
vim.keymap.set("n", "<leader>cv", ":ToggleTerm direction=vertical size=60<CR>", {})
vim.keymap.set("n", "<leader>ch", ":ToggleTerm direction=horizontal size=12<CR>", {})
----------------------------------------------------------------------------------

--------------------------- keymap for buffer navigation -------------------------
vim.keymap.set("n", "<leader>we", ":bnext<CR>", {})
vim.keymap.set("n", "<leader>wq", ":bprev<CR>", {})
----------------------------------------------------------------------------------

------------------------------ LazyGit Config ------------------------------------
vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
vim.g.lazygit_floating_window_scaling_factor = 0.85 -- scaling factor for floating window
vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- customize lazygit popup window border characters
vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
vim.g.lazygit_config_file_path = "" -- custom config file path
-- OR
-- vim.g.lazygit_config_file_path = {} -- table of custom config file paths
----------------------------------------------------------------------------------

---------------------------------- GIT Signs -------------------------------------
-- vim.keymap.set('n', '<leader>td', gs.toggle_deleted, {})
----------------------------------------------------------------------------------

vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })

vim.diagnostic.get(0, {
	severity = {
		vim.diagnostic.severity.WARN,
		vim.diagnostic.severity.INFO,
	},
})

-- It's good practice to namespace custom handlers to avoid collisions
vim.diagnostic.handlers["my/notify"] = {
	show = function(namespace, bufnr, diagnostics, opts)
		-- In our example, the opts table has a "log_level" option
		local level = opts["my/notify"].log_level
		local name = vim.diagnostic.get_namespace(namespace).name
		local msg = string.format("%d diagnostics in buffer %d from %s", #diagnostics, bufnr, name)
		vim.notify(msg, level)
	end,
}
-- Users can configure the handler
vim.diagnostic.config({
	["my/notify"] = {
		log_level = vim.log.levels.INFO,
	},
})

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"jsonls",
		"rust_analyzer",
		"quick_lint_js",
		"tsserver",
		"html",
		"clangd",
		"jedi_language_server",
		"sqlls",
		"sqls",
		"pylsp",
		--"pylyzer",
		--"pyre",
		--"pyright",
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({ capabilities = capabilities })
lspconfig.rust_analyzer.setup({ capabilities = capabilities })
lspconfig.tsserver.setup({
	capabilities = capabilities,
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
})
lspconfig.quick_lint_js.setup({ capabilities = capabilities })
lspconfig.html.setup({ capabilities = capabilities })
lspconfig.jsonls.setup({ capabilities = capabilities })
lspconfig.clangd.setup({ capabilities = capabilities })
lspconfig.jedi_language_server.setup({ capabilities = capabilities })
lspconfig.sqlls.setup({ capabilities = capabilities })
lspconfig.sqls.setup({ capabilities = capabilities })
lspconfig.pylsp.setup({ capabilities = capabilities })
-- lspconfig.pyre.setup({ capabilities = capabilities })
-- lspconfig.pylyzer.setup({ capabilities = capabilities })
-- lspconfig.pyright.setup({ capabilities = capabilities })

local null_ls = require("null-ls")

local h = require("null-ls.helpers")
local cmd_resolver = require("null-ls.helpers.command_resolver")
local methods = require("null-ls.methods")
local u = require("null-ls.utils")

local FORMATTING = methods.internal.FORMATTING
local RANGE_FORMATTING = methods.internal.RANGE_FORMATTING
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier.with({
			method = { FORMATTING, RANGE_FORMATTING },
			generator_opts = {
				command = "prettier",
				args = h.range_formatting_args_factory({
					"--stdin-filepath",
					"$FILENAME",
				}, "--range-start", "--range-end", { row_offset = -1, col_offset = -1 }),
				"--tab-width",
				"-1",
				"--use-tabs",
				to_stdin = true,
				dynamic_command = cmd_resolver.from_node_modules(),
				cwd = h.cache.by_bufnr(function(params)
					return u.root_pattern(
						-- https://prettier.io/docs/en/configuration.html
						".prettierrc",
						".prettierrc.json",
						".prettierrc.yml",
						".prettierrc.yaml",
						".prettierrc.json5",
						".prettierrc.js",
						".prettierrc.cjs",
						".prettierrc.toml",
						"prettier.config.js",
						"prettier.config.cjs",
						"package.json"
					)(params.bufname)
				end),
			},
			factory = h.formatter_factory,
		}),
		null_ls.builtins.completion.spell,
		null_ls.builtins.code_actions.gitsigns,
	},
	-- on_attach = function(current_client, bufnr)
	-- 	if current_client.supports_method("textDocument/formatting") then
	-- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	-- 		vim.api.nvim_create_autocmd("BufWritePre", {
	-- 			group = augroup,
	-- 			buffer = bufnr,
	-- 			callback = function()
	-- 				vim.lsp.buf.format({
	-- 					filter = function(client)
	-- 						-- only use null-ls for formatting instead of lsp server
	-- 						return client.name == "null-ls"
	-- 					end,
	-- 					bufnr = bufnr,
	-- 				})
	-- 			end,
	-- 		})
	-- 	end
	-- end,
})

-- vim.lsp.buf.format({
-- 	filter = function(client)
-- 		-- only use null-ls for formatting instead of lsp server
-- 		return client.name == "quick_lint_js"
-- 	end,
-- })

local formatting = null_ls.builtins.formatting
null_ls.setup({
	sources = {
		formatting.prettier.with({
			filetypes = { "javascript", "typescript", "html", "css", "json" },
			-- set tab width to 2 and use tabs instead of spaces
			args = { "--stdin-filepath", "$FILENAME", "--tab-width", "1", "--use-tabs" },
		}),
	},
})
local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
		{ name = "vim-dadbod-completion" },
		{ name = "path" },
		{ name = "buffer", keyword_length = 5 },
	}, {
		{ name = "buffer" },
	}),
	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources({
			{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
		}, {
			{ name = "buffer" },
		}),
	}),

	-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline("/", {
		sources = {
			{ name = "buffer" },
		},
	}),

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(":", {
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	}),
})

-- require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })

require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
	defaults = {
		history = {
			path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
			limit = 100,
		},
		file_ignore_patterns = { "node_modules/.*" },
	},
})

require("telescope").load_extension("ui-select")
-- require('telescope').load_extension('smart_history')

local latte = require("catppuccin.palettes").get_palette("latte")
local frappe = require("catppuccin.palettes").get_palette("frappe")
local macchiato = require("catppuccin.palettes").get_palette("macchiato")
local mocha = require("catppuccin.palettes").get_palette("mocha")

require("catppuccin").setup({
	flavour = "frappe", -- latte, frappe, macchiato, mocha
	flavours = { latte = 1, frappe = 2, macchiato = 3, mocha = 4 },
	background = { -- :h background
		light = "mocha",
		dark = "frappe",
	},
	transparent_background = true,
	styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = { "italic" }, -- Change the style of comments
		conditionals = { "italic" },
		loops = {},
		functions = { "bold" },
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = { "bold" },
		properties = {},
		types = {},
		operators = {},
	},
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		notify = true,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = {},
				warnings = { "underline" },
				information = {},
			},
			inlay_hints = {
				background = true,
			},
		},
	},
	color_overrides = {
		all = {
			text = "#c9f0e0",
		},
		latte = {
			base = "#ff0000",
			mantle = "#242424",
			crust = "#474747",
		},
		frappe = frappe,
		macchiato = macchiato,
		mocha = mocha,
	},
	highlight_overrides = {
		all = function(colors)
			return {
				NvimTreeNormal = { fg = colors.none },
				CmpBorder = { fg = "#3e4145" },
			}
		end,
		latte = function(latte)
			return {
				Normal = { fg = latte.base },
			}
		end,
		frappe = function(frappe)
			return {
				["@comment"] = { fg = frappe.surface2, style = { "italic" } },
			}
		end,
		macchiato = function(macchiato)
			return {
				LineNr = { fg = macchiato.overlay1 },
			}
		end,
		mocha = function(mocha)
			return {
				Comment = { fg = mocha.flamingo },
			}
		end,
	},
})

vim.cmd.colorscheme("catppuccin")

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

require("solarized-osaka").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	transparent = true, -- Enable this to disable setting the background color
	terminal_colors = false, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		functions = { bold = true },
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "transparent", -- style for sidebars, see below
		floats = "transparent", -- style for floating windows
	},
	sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.7, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = false, -- dims inactive windows
	lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

	--- You can override specific color groups to use other groups or a hex color
	--- function will be called with a ColorScheme table
	---@param colors ColorScheme
	on_colors = function(colors)
		colors.hint = colors.yellow
		colors.error = "#ff0000"
	end,
	--- You can override specific highlights to use other groups or a hex color
	--- function will be called with a Highlights and ColorScheme table
	---@param highlights Highlights
	---@param colors ColorScheme
	on_highlights = function(hl, c)
		local prompt = "#2d3149"
		hl.TelescopeNormal = {
			bg = c.bg_dark,
			fg = c.fg_dark,
		}
		hl.TelescopeBorder = {
			bg = c.bg_dark,
			fg = c.fg_dark,
		}
		hl.TelescopePromptNormal = {
			bg = c.bg_dark,
		}
		hl.TelescopePromptBorder = {
			bg = c.bg_dark,
			fg = c.fg_dark,
		}
		hl.TelescopePromptTitle = {
			bg = c.bg_dark,
			fg = c.fg_dark,
		}
		hl.TelescopePreviewTitle = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
		hl.TelescopeResultsTitle = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
	end,
})

-- require("solarized-osaka")._load("storm")

-- vim.cmd([[colorscheme solarized-osaka]])

local lualine = require("lualine")

-- Color table for highlights
-- stylua: ignore
local colors = {
	bg          = '#202328',
	fg          = '#bbc2cf',
	yellow      = '#ECBE7B',
	p_yellow    = '#e4f00e',
	cyan        = '#008080',
	darkblue    = '#081633',
	green       = '#98be65',
	orange      = '#FF8800',
	violet      = '#a9a1e1',
	magenta     = '#c678dd',
	blue        = '#51afef',
	red         = '#ec5f67',
	black       = '#090a04',
	grey        = '#a0a1a7',
	white       = '#f3f3f3',
	light_green = '#83a598',
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

function Harpoon_files()
	local contents = {}
	local marks_length = harpoon:list():length()
	local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
	for index = 1, marks_length do
		local harpoon_file_path = harpoon:list():get(index).value
		local file_name = harpoon_file_path == "" and "(empty)" or vim.fn.fnamemodify(harpoon_file_path, ":t")

		if current_file_path == harpoon_file_path then
			contents[index] = string.format("%%#HarpoonNumberActive# %s. %%#HarpoonActive#%s ", index, file_name)
		else
			contents[index] = string.format("%%#HarpoonNumberInactive# %s. %%#HarpoonInactive#%s ", index, file_name)
		end
	end

	return table.concat(contents)
end

local Dev = require("harpoon.dev")
local log = Dev.log

local M = {}
local function get_color(group, attr)
	return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end

local function shorten_filenames(filenames)
	local shortened = {}

	local counts = {}
	for _, file in ipairs(filenames) do
		local name = vim.fn.fnamemodify(file.filename, ":t")
		counts[name] = (counts[name] or 0) + 1
	end

	for _, file in ipairs(filenames) do
		local name = vim.fn.fnamemodify(file.filename, ":t")

		if counts[name] == 1 then
			table.insert(shortened, { filename = vim.fn.fnamemodify(name, ":t") })
		else
			table.insert(shortened, { filename = file.filename })
		end
	end

	return shortened
end
function tprint(tbl, indent)
	if not indent then
		indent = 0
	end
	local toprint = string.rep(" ", indent) .. "{\r\n"
	indent = indent + 2
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if type(k) == "number" then
			toprint = toprint .. "[" .. k .. "] = "
		elseif type(k) == "string" then
			toprint = toprint .. k .. "= "
		end
		if type(v) == "number" then
			toprint = toprint .. v .. ",\r\n"
		elseif type(v) == "string" then
			toprint = toprint .. '"' .. v .. '",\r\n'
		elseif type(v) == "table" then
			toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
		else
			toprint = toprint .. '"' .. tostring(v) .. '",\r\n'
		end
	end
	toprint = toprint .. string.rep(" ", indent - 2) .. "}"
	return toprint
end

local tabs = shorten_filenames(require("harpoon").get_mark_config().marks)
-- print("Harpoon TABS------------------->>>>>>>>>>>>>", tprint(tabs))
local Index = require("harpoon.mark").get_index_of(vim.fn.bufname())
-- print("Harpoon Index---------------->>>>>>>>>>>>>>", Index)
local InnObj = {}
for k, v in pairs(tabs) do
	-- print("for------------>>>>>>>>>>>", k, v.filename)
	InnObj[k] = function()
		return tabs[k].filename
	end
end
-- print("INNER OBJ------------------>>>>>>>>>>>", InnObj[1](), InnObj[2]())
--print("PRIMEAGEN--------------->>>>>>>>>>>>", vim.harpoon)
function Taber()
	local tabs = shorten_filenames(require("harpoon").get_mark_config().marks)
	local index = require("harpoon.mark").get_index_of(vim.fn.bufname())
	-- print("Harpoon TABS------------------->>>>>>>>>>>>>", tprint(tabs))
	local InnObj = {}
	for k, v in pairs(tabs) do
		-- print("for------------>>>>>>>>>>>", k, v.filename)
		InnObj[k] = {
			function()
				local index = require("harpoon.mark").get_index_of(vim.fn.bufname())
				vim.fn.bufname()
				return string.format(" %s ", tabs[k].filename)
			end,
			component = { right = "" },
		}
	end
	return InnObj
end



-- vim.keymap.set("n", "<leader>hh", Taber, {})

function Header()
	return {
		-- "filename",
		function()
			return string.format(vim.fn.bufname())
		end,
		color = { bg = colors.blue },
		separator = {
			right = "",
		},
	}
end

function M.setup(opts)
	function _G.tabline()
		local tabs = shorten_filenames(require("harpoon").get_mark_config().marks)
		local tabline = ""

		local index = require("harpoon.mark").get_index_of(vim.fn.bufname())

		for i, tab in ipairs(tabs) do
			local is_current = i == index

			local label

			if tab.filename == "" or tab.filename == "(empty)" then
				label = "(empty)"
				is_current = false
			else
				label = tab.filename
			end

			if is_current then
				tabline = tabline
					.. "%#HarpoonNumberActive#"
					.. (opts.tabline_prefix or "   ")
					.. i
					.. " %*"
					.. "%#HarpoonActive#"
			else
				tabline = tabline
					.. "%#HarpoonNumberInactive#"
					.. (opts.tabline_prefix or "   ")
					.. i
					.. " %*"
					.. "%#HarpoonInactive#"
			end

			tabline = tabline .. label .. (opts.tabline_suffix or "   ") .. "%*"

			if i < #tabs then
				tabline = tabline .. "%T"
			end
		end

		return tabline
	end

	vim.opt.showtabline = 2

	vim.o.tabline = "%!v:lua.tabline()"

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("harpoon", { clear = true }),
		pattern = { "*" },
		callback = function()
			local color = get_color("HarpoonActive", "bg#")

			if color == "" or color == nil then
				vim.api.nvim_set_hl(0, "HarpoonInactive", { link = "Tabline" })
				vim.api.nvim_set_hl(0, "HarpoonActive", { link = "TablineSel" })
				vim.api.nvim_set_hl(0, "HarpoonNumberActive", { link = "TablineSel" })
				vim.api.nvim_set_hl(0, "HarpoonNumberInactive", { link = "Tabline" })
			end
		end,
	})

	log.debug("setup(): Tabline Setup", opts)
end

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		--
		icons_enabled = true,
		ignore_focus = {},
		always_divide_middle = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},

		-- component_separators = { left = "", right = "" },
		component_separators = "",
		section_separators = { left = "", right = "" },
		--	theme = {
		--		-- We are going to use lualine_c an lualine_x as left and
		--		-- right section. Both are highlighted by c theme .  So we
		--		-- are just setting default looks o statusline
		--		normal = {
		--			a = { fg = colors.black, bg = colors.p_yellow },
		--			b = { fg = colors.white, bg = colors.grey },
		--			c = { fg = colors.black, bg = colors.white },
		--			z = { fg = colors.white, bg = colors.black },
		--			c = { fg = colors.magenta, bg = colors.bg },
		--		},
		--		inactive = { c = { fg = colors.fg, bg = colors.bg } },
		--	},
		theme = "powerline_dark",
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_y = {
			{
				"progress",
				color = function()
					local mode_color = {
						n = "#fafa12",
						i = colors.blue,
						v = colors.orange,
						["␖"] = colors.blue,
						V = colors.blue,
						c = "#2abd0d",
						no = colors.red,
						s = colors.orange,
						S = colors.orange,
						["␓"] = colors.orange,
						ic = colors.yellow,
						R = colors.violet,
						Rv = colors.violet,
						cv = colors.red,
						ce = colors.red,
						r = colors.cyan,
						rm = colors.cyan,
						["r?"] = colors.cyan,
						["!"] = colors.red,
						t = colors.red,
					}
					return {
						bg = mode_color[vim.fn.mode()],
						fg = colors.black,
						gui = "bold",
					}
				end,
				-- padding = { left = 1 , right = 0.5 },
				-- separator = { right = "", left = "" },
			},
		},
		lualine_z = {
			{
				"location",
				color = function()
					local mode_color = {
						n = "#3e4b48",
						i = "#3105a1",
						v = "#2e3b38",
						["␖"] = colors.blue,
						V = colors.blue,
						c = "#323d3b",
						no = colors.red,
						s = colors.orange,
						S = colors.orange,
						["␓"] = colors.orange,
						ic = colors.yellow,
						R = colors.violet,
						Rv = colors.violet,
						cv = colors.red,
						ce = colors.red,
						r = colors.cyan,
						rm = colors.cyan,
						["r?"] = colors.cyan,
						["!"] = colors.red,
						t = colors.red,
					}

					return {
						bg = mode_color[vim.fn.mode()],
						fg = colors.white,
						gui = "bold",
					}
				end,
			},
			{
				function()
					return "▊"
				end,
				color = { fg = colors.grey, bg = "#3e4b48" },
				padding = { left = 0, right = 0 },
			},
		}, -- "location"
		-- These will be filled later
		lualine_c = {
			-- project_root,
			-- 	{ "filename", file_status = true, newfile_status = true, path = 1 },
		}, --lualine_x = {},
		lualine_x = { "filetype", { "fileformat", padding = { left = 1, right = 2 } } },
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
	-- tabline = {
	-- tabline	lualine_a = { Header() },
	-- tabline	lualine_b =  Taber(),
	-- tabline	lualine_c = { bg = nil, guibg = nil },
	-- tabline	lualine_z = { bg = nil, guibg = nil },
	-- tabline	lualine_y = { bg = nil, guibg = nil },
	-- tabline	lualine_x = { bg = nil, guibg = nil },
	-- tabline},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

-- ins_left({
-- 	function()
-- 		return "▊"
-- 	end,
-- 	color = { fg = colors.blue }, -- Sets highlighting of component
-- 	padding = { left = 0, right = 1 }, -- We don't need space before this
-- })

ins_left({
	-- mode component
	function()
		return ""
	end,
	color = function()
		-- auto change color according to neovims mode
		local mode_color = {
			n = colors.red,
			i = colors.green,
			v = colors.blue,
			["␖"] = colors.blue,
			V = colors.blue,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			["␓"] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}
		return { fg = mode_color[vim.fn.mode()] }
	end,
	padding = { left = 1, right = 1 },
})

ins_left({
	-- filesize component
	"filesize",
	cond = conditions.buffer_not_empty,
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = colors.magenta, gui = "bold" },
})

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { warn = " ", info = " ", error = "☠️  " },
	diagnostics_color = {
		color_warn = { fg = colors.yellow },
		color_info = { fg = colors.cyan },
		color_error = { fg = colors.red },
	},
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2

-- ins_left({
-- 	function()
-- 		return "%="
-- 	end,
-- })

ins_left({
	function()
		return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	end,
	icon = "",
	color = { fg = colors.green },
	-- cond = hide_in_width,
	-- separator = " ",
})
ins_left({
	-- Lsp server name .
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = " ",
	color = { fg = "#ffffff", gui = "bold" },
	-- color = { fg = colors.green, gui = "bold" },
})

-- Add components to right sections
-- ins_right({
-- 	"o:encoding", -- option component same as &encoding in viml
-- 	fmt = string.upper, -- I'm not sure why it's upper case either ;)
-- 	cond = conditions.hide_in_width,
-- 	color = { fg = colors.green, gui = "bold" },
-- 	padding = { left = 1, right = 1 },
-- })

-- ins_right({
-- 	"fileformat",
-- 	fmt = string.upper,
-- 	icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
-- 	color = { fg = colors.green, gui = "bold" },
-- })

-- ins_right({
-- 	"branch",
-- 	icon = "",
-- 	color = { fg = colors.violet, gui = "bold" },
-- })

-- ins_right({
-- 	"diff",
-- 	-- Is it me or the symbol for modified us really weird
-- 	symbols = { added = "+", modified = "~", removed = " " },
-- 	diff_color = {
-- 		added = { fg = colors.green },
-- 		modified = { fg = colors.orange },
-- 		removed = { fg = colors.red },
-- 	},
-- 	cond = conditions.hide_in_width,
-- })

-- ins_right({ "location", colors = { gui = "bold" } })

lualine.setup(config)

require("nvim-web-devicons").get_icons()

-- require("nvim-web-devicons").get_icon_by_filetype(filetype, opts)
-- require("nvim-web-devicons").get_icon_colors_by_filetype(filetype, opts)
-- require("nvim-web-devicons").get_icon_color_by_filetype(filetype, opts)
-- require("nvim-web-devicons").get_icon_cterm_color_by_filetype(filetype, opts)

vim.api.nvim_create_user_command("Cppath", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

require("mini.indentscope").setup(
	-- No need to copy this inside `setup()`. Will be used automatically.
	{
		-- Draw options
		--	draw = {
		--		-- Delay (in ms) between event and start of drawing scope indicator
		--		delay = 100,

		--		-- Animation rule for scope's first drawing. A function which, given
		--		-- next and total step numbers, returns wait time (in ms). See
		--		-- |MiniIndentscope.gen_animation| for builtin options. To disable
		--		-- animation, use `require('mini.indentscope').gen_animation.none()`.
		--		-- animation = --<function: implements constant 20ms between steps>,

		--		-- Symbol priority. Increase to display on top of more symbols.
		--		priority = 2,
		--	},

		--	-- Module mappings. Use `''` (empty string) to disable one.
		--	mappings = {
		--		-- Textobjects
		--		object_scope = "ii",
		--		object_scope_with_border = "ai",

		--		-- Motions (jump to respective border line; if not present - body line)
		--		goto_top = "[i",
		--		goto_bottom = "]i",
		--	},

		--	-- Options which control scope computation
		--	options = {
		--		-- Type of scope's border: which line(s) with smaller indent to
		--		-- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
		--		border = "both",

		--		-- Whether to use cursor column when computing reference indent.
		--		-- Useful to see incremental scopes with horizontal cursor movements.
		--		indent_at_cursor = true,

		--		-- Whether to first check input line to be a border of adjacent scope.
		--		-- Use it if you want to place cursor on function header to get scope of
		--		-- its body.
		--		try_as_border = true,
		--	},

		--	-- Which character to use for drawing scope indicator
		--	symbol = "╎",
	}
)

require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "-" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		follow_files = true,
	},
	auto_attach = true,
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	yadm = {
		enable = false,
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		-- Actions
		-- map("n", "<leader>hs", gs.stage_hunk)
		-- map("n", "<leader>hr", gs.reset_hunk)
		-- map("v", "<leader>hs", function()
		-- 	gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		-- end)
		-- map("v", "<leader>hr", function()
		-- 	gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		-- end)
		-- map("n", "<leader>hS", gs.stage_buffer)
		-- map("n", "<leader>hu", gs.undo_stage_hunk)
		-- map("n", "<leader>hR", gs.reset_buffer)
		vim.keymap.set("n", "<leader>hp", gs.preview_hunk)
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, {})
		vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, {})
		vim.keymap.set("n", "<leader>hd", gs.diffthis, {})
		vim.keymap.set("n", "<leader>hD", function()
			gs.diffthis("~")
		end, {})
		vim.keymap.set("n", "<leader>td", gs.toggle_deleted)

		-- Text object
		vim.keymap.set({ "o", "x" }, "<leader>ih", ":<C-U>Gitsigns select_hunk<CR>", {})
	end,
})

-- execute a Vimscript command to listen to the HarpoonEnter event
-- vim.api.nvim_exec([[
-- -- augroup HarpoonEvents
-- -- autocmd!
-- -- autocmd User HarpoonEnter echo "You entered a harpoon buffer!"
-- -- augroup END
-- ]], false)

-- This will print a message whenever you enter a harpoon buffer.
-- You can also use the vim.api.nvim_buf_attach()function to attach a Lua callback function
-- to a specific buffer. For example:

-- get the buffer number of the first harpoon mark
-- local bufnr = require("harpoon.mark").get_marked_file
-- print("BUFFFF_NRRRR=================>>>>>>>>>>", vim.inspect(bufnr))

-- -- define a Lua callback function to handle buffer events
--  local on_event = function(_, bufnr, _, name, _)
--  	if name == "changedtick" then
--  		-- do something when the buffer is changed
--  		print("The buffer " .. bufnr .. " was changed!")
--  	end
--  end
--  -- attach the callback function to the buffer
--  vim.api.nvim_buf_attach(bufnr, false, {
--  	on_event = on_event,
--  })

-- This will print a message whenever the buffer of the first harpoon mark is changed.
-- You can also use the vim.api.nvim_command_output() function to capture the output of a harpoon command.
-- For example:

-- capture the output of the harpoon status command
-- local output = vim.api.nvim_command_output("HarpoonStatus")
-- -- print the output
-- print(output)
--

require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt", "vim" },
	check_ts = true,
	ts_config = {
		lua = { "string" }, -- it will not add a pair on that treesitter node
		javascript = { "template_string" },
		java = false, -- don't check treesitter on java
	},
})

local Rule = require("nvim-autopairs.rule")
local ts_conds = require("nvim-autopairs.ts-conds")

require("nvim-autopairs").add_rules({
	Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
	Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
})

require("nvim-surround").setup({
	-- Configuration here, or leave empty to use defaults
})

-- default config
-- require("image").setup({
-- 	backend = "kitty",
-- 	integrations = {
-- 		markdown = {
-- 			enabled = true,
-- 			clear_in_insert_mode = false,
-- 			download_remote_images = true,
-- 			only_render_image_at_cursor = false,
-- 			filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
-- 			markdown = {
-- 				resolve_image_path = function(document_path, image_path, fallback)
-- 					-- document_path is the path to the file that contains the image
-- 					-- image_path is the potentially relative path to the image. for
-- 					-- markdown it's `![](this text)`
--
-- 					-- you can call the fallback function to get the default behavior
-- 					return fallback(document_path, image_path)
-- 				end,
-- 			},
-- 		},
-- 		neorg = {
-- 			enabled = true,
-- 			clear_in_insert_mode = false,
-- 			download_remote_images = true,
-- 			only_render_image_at_cursor = false,
-- 			filetypes = { "norg" },
-- 		},
-- 	},
-- 	max_width = nil,
-- 	max_height = nil,
-- 	max_width_window_percentage = nil,
-- 	max_height_window_percentage = 50,
-- 	window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
-- 	window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
-- 	editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
-- 	tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
-- 	hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
-- })

-- require("noice").setup({
-- 	 cmdline = {
--     enabled = true, -- enables the Noice cmdline UI
--     view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
--     opts = {}, -- global options for the cmdline. See section on views
--     ---@type table<string, CmdlineFormat>
--     format = {
--       -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
--       -- view: (default is cmdline view)
--       -- opts: any options passed to the view
--       -- icon_hl_group: optional hl_group for the icon
--       -- title: set to anything or empty string to hide
--       cmdline = { pattern = "^:", icon = "", lang = "vim" },
--       search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
--       search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
--       filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
--       lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
--       help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
--       input = {}, -- Used by input()
--       -- lua = false, -- to disable a format, set to `false`
--     },
--   },
-- 	lsp = {
-- 		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
-- 		override = {
-- 			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
-- 			["vim.lsp.util.stylize_markdown"] = true,
-- 			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
-- 		},
-- 	},
-- 	-- you can enable a preset for easier configuration
-- 	presets = {
-- 		bottom_search = true, -- use a classic bottom cmdline for search
-- 		command_palette = true, -- position the cmdline and popupmenu together
-- 		long_message_to_split = true, -- long messages will be sent to a split
-- 		inc_rename = false, -- enables an input dialog for inc-rename.nvim
-- 		lsp_doc_border = false, -- add a border to hover docs and signature help
-- 	},
-- })
--
--
--
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
		FloatBorder = {
			guifg = "#0000ff",
			guibg = "#0000ff",
		},
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

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	--	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	-- 	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
