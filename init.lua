local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
vim.opt.mouse = ""
vim.opt.wrap = false
vim.opt.number = true
vim.opt.laststatus = 3
vim.opt.inccommand = "split"
vim.opt.termguicolors = true
vim.opt.relativenumber = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

local opts = {}

require("lazy").setup("plugins", opts)

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
		"git_config",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		--"regex",
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

require("telescope").load_extension("lazygit")

-- local positive_look_behind = function(opts_1)
-- 	local cmd = ".,+22s/\\(" .. tostring(vim.fn.getreg("0")) .. "\\)\\@<=.*/" .. opts_1.args .. "/"
-- 	print(cmd)
-- 	vim.api.nvim_command(cmd)
-- 	return 0
-- end
--
-- vim.api.nvim_create_user_command("Pchange", positive_look_behind, { nargs = "?" })

-- vim.keymap.set("n", "<leader>lb", positive_look_behind)

local last_status_flag = 3
local last_status = function()
	local cmd
	if last_status_flag == 3 then
		cmd = "set laststatus=" .. last_status_flag
		last_status_flag = 2
	elseif last_status_flag == 2 then
		cmd = "set laststatus=" .. last_status_flag
		last_status_flag = 3
	end
	vim.api.nvim_command(cmd)
end
vim.keymap.set("n", "<leader>ll", last_status, {})

local TshiftToggleConst = "2"
local shift_theme = function(opts_theme)
	if opts_theme.args == "sol" then
		vim.cmd.colorscheme("solarized-osaka")
	elseif opts_theme.args == "cat" then
		vim.cmd.colorscheme("catppuccin")
	elseif opts_theme.args == "Toggle" then
		if TshiftToggleConst == "1" then
			TshiftToggleConst = "2"
			vim.api.nvim_command("colorscheme catppuccin")
		elseif TshiftToggleConst == "2" then
			TshiftToggleConst = "3"
			vim.api.nvim_command("colorscheme solarized-osaka")
		elseif TshiftToggleConst == "3" then
			TshiftToggleConst = "1"
			vim.api.nvim_command("colorscheme tokyonight-night")
		end
	end
end
vim.api.nvim_create_user_command("Tshift", shift_theme, { nargs = "?" })
vim.keymap.set("n", "<leader>cs", ":Tshift Toggle<CR>", {})

-- local harpoon = require("telescope").load_extension("harpoon")

---------------------------- keymap for search escape ----------------------------
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
----------------------------------------------------------------------------------

--------------------------- keymap for diagnostics jump --------------------------
vim.keymap.set("n", "]d", ":lua vim.diagnostic.goto_next()<CR>", {})
vim.keymap.set("n", "[d", ":lua vim.diagnostic.goto_prev()<CR>", {})
----------------------------------------------------------------------------------

------------------------------- keymap for telescope ------------------------------
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fn", builtin.tags, {})
vim.keymap.set("n", "<leader>fs", builtin.search_history, {})
vim.keymap.set("n", "<leader>fe", builtin.resume, {})
vim.keymap.set("n", "<leader>fp", builtin.pickers, {})
vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
vim.keymap.set("n", "<leader>fc", builtin.colorscheme, {})
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
vim.keymap.set("n", "<leader>fq", builtin.quickfix, {})
vim.keymap.set("n", "<leader>fi", builtin.registers, {})
vim.keymap.set("n", "<leader>fy", builtin.autocommands, {})
vim.keymap.set("n", "<leader>fz", builtin.command_history, {})
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags theme=ivy<CR>")
vim.keymap.set("n", "<leader>fm", ":Telescope marks theme=ivy<CR>")
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep theme=ivy<CR>")
vim.keymap.set("n", "<leader>fd", ":Telescope diagnostics theme=ivy<CR>")
vim.keymap.set("n", "<leader>fu", ":Telescope autocommands theme=ivy<CR>")
vim.keymap.set("n", "<leader>fr", ":Telescope live_grep theme=dropdown<CR>", {})
vim.keymap.set("n", "<leader>fx", ":Telescope find_files theme=ivy<CR>", {})
vim.keymap.set("n", "<leader>ft", ":Telescope find_files hidden=true<CR>", {})
vim.keymap.set("n", "<leader>fa", ":Telescope find_files find_command=rg,--ignore,--hidden,--files,-u<CR>", {})
-----------------------------------------------------------------------------------

------------------------------ keymap for lsp-buffer ------------------------------
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
-----------------------------------------------------------------------------------

------------------------------ keymap for none-ls ---------------------------------
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
vim.keymap.set("v", "<Leader>1f", vim.lsp.buf.format, {})
-----------------------------------------------------------------------------------

---------------------------------- keymap for harpoon -------------------------------------
vim.keymap.set("n", "<leader>th", ":Telescope harpoon marks<CR>", {})
vim.keymap.set("n", "<C-j>", require("harpoon.ui").nav_prev) -- navigates to previous mark
vim.keymap.set("n", "<C-k>", require("harpoon.ui").nav_next) -- navigates to next mark
vim.keymap.set("n", "<C-q>", require("harpoon.ui").nav_next) -- navigates to next mark
vim.keymap.set("n", "<leader>z", require("harpoon.ui").toggle_quick_menu, {})
vim.keymap.set("n", "m1", ':lua require("harpoon.ui").nav_file(1)<CR>', { silent = true })
vim.keymap.set("n", "m2", ':lua require("harpoon.ui").nav_file(2)<CR>', { silent = true })
vim.keymap.set("n", "m3", ':lua require("harpoon.ui").nav_file(3)<CR>', { silent = true })
vim.keymap.set("n", "m4", ':lua require("harpoon.ui").nav_file(4)<CR>', { silent = true })
vim.keymap.set("n", "m5", ':lua require("harpoon.ui").nav_file(5)<CR>', { silent = true })
vim.keymap.set("n", "m6", ':lua require("harpoon.ui").nav_file(6)<CR>', { silent = true })
vim.keymap.set("n", "m7", ':lua require("harpoon.ui").nav_file(7)<CR>', { silent = true })
vim.keymap.set("n", "m8", ':lua require("harpoon.ui").nav_file(8)<CR>', { silent = true })
vim.keymap.set("n", "m9", ':lua require("harpoon.ui").nav_file(9)<CR>', { silent = true })
vim.keymap.set("n", "<leader>hh", function()
	require("harpoon.mark").add_file()
	vim.cmd("edit")
end, {})
--------------------------------------------------------------------------------------------

------------------------------- Harpoon Theme customize -----------------------------
vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
vim.cmd("highlight! HarpoonActive guibg=NONE guifg=white")
vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
vim.cmd("highlight! TabLineFill guibg=#d9280d guifg=#d9280d")
-------------------------------------------------------------------------------------

-------------------------------- keymap for toggle-term -----------------------------
vim.keymap.set("n", "<leader>cf", ":ToggleTerm direction=float size=20<CR>", {})
vim.keymap.set("n", "<leader>cv", ":ToggleTerm direction=vertical size=60<CR>", {})
vim.keymap.set("n", "<leader>ch", ":ToggleTerm direction=horizontal size=12<CR>", {})
-------------------------------------------------------------------------------------

---------------------------- keymap for buffer navigation ---------------------------
vim.keymap.set("n", "<leader>we", ":bnext<CR>", {})
vim.keymap.set("n", "<leader>wq", ":bprev<CR>", {})
-------------------------------------------------------------------------------------

---------------------------- keymap for tab navigation ------------------------------
vim.keymap.set("n", "<leader>tt", ":tabnext<CR>", {}) -- next tab
vim.keymap.set("n", "<leader>ty", ":tabnext<CR>", {}) -- next tab
vim.keymap.set("n", "<leader>tr", ":tabprevious<CR>", {}) -- previous tab
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", {}) -- next tab
-------------------------------------------------------------------------------------

----------------------------- window binding in a tab -------------------------------
vim.keymap.set("n", "<leader>ba", function()
	local curr_line_num = tostring(vim.api.nvim__buf_stats(0).current_lnum)
	vim.cmd("windo" .. " " .. curr_line_num)
	vim.cmd("windo set cursorbind cursorline")
	vim.notify("Binded all Windows")
end, {})
vim.keymap.set("n", "<leader>bn", function()
	vim.cmd("windo set nocursorbind nocursorline")
	vim.notify("Unbinded all Windows")
end, {})
-------------------------------------------------------------------------------------

--------------------------- Accidental closing prevention ---------------------------
vim.keymap.set("n", "<c-z>", function()
	vim.notify("you just got saved from an unwanted headache !!!!!")
end, {})
-------------------------------------------------------------------------------------

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

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "󰳳",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		-- "quick_lint_js",
		"tsserver",
		"html",
		"jsonls",
		"cssls",
		"vimls",
		"emmet_ls",
		"volar",
		"angularls",
		"clangd",
		"sqls",
		"pylsp",
		"gopls",
		"bashls",
		"ltex",
		"yamlls",
		"vale_ls",
		"intelephense",
		"diagnosticls",
		"jedi_language_server",
	},
})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = { hint = { enable = true } },
	},
})
lspconfig.rust_analyzer.setup({ capabilities = capabilities })
lspconfig.tsserver.setup({
	capabilities = capabilities,
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
})
-- lspconfig.quick_lint_js.setup({ capabilities = capabilities })
lspconfig.html.setup({ capabilities = capabilities })
lspconfig.cssls.setup({ capabilities = capabilities })
lspconfig.jsonls.setup({ capabilities = capabilities })
lspconfig.volar.setup({ capabilities = capabilities })
lspconfig.angularls.setup({ capabilities = capabilities })
lspconfig.clangd.setup({ capabilities = capabilities })
lspconfig.sqls.setup({ capabilities = capabilities })
lspconfig.pylsp.setup({ capabilities = capabilities })
lspconfig.emmet_ls.setup({ capabilities = capabilities })
lspconfig.gopls.setup({ capabilities = capabilities })
lspconfig.dartls.setup({ capabilities = capabilities })
lspconfig.bashls.setup({ capabilities = capabilities })
-- lspconfig.ltex.setup({ capabilities = capabilities })
lspconfig.vimls.setup({ capabilities = capabilities })
lspconfig.yamlls.setup({ capabilities = capabilities })
lspconfig.vale_ls.setup({ capabilities = capabilities })
lspconfig.intelephense.setup({ capabilities = capabilities })
lspconfig.diagnosticls.setup({ capabilities = capabilities })
lspconfig.jedi_language_server.setup({ capabilities = capabilities })

local null_ls = require("null-ls")

local h = require("null-ls.helpers")
-- local cmd_resolver = require("null-ls.helpers.command_resolver")
local methods = require("null-ls.methods")
-- local u = require("null-ls.utils")

local FORMATTING = methods.internal.FORMATTING
local RANGE_FORMATTING = methods.internal.RANGE_FORMATTING
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "javascript", "typescript", "html", "css", "json" },
			method = { FORMATTING, RANGE_FORMATTING },
			-- generator_opts = {
			-- 	command = "prettier",
			-- 	args = h.range_formatting_args_factory({
			-- 		"--stdin-filepath",
			-- 		"$FILENAME",
			-- 	}, "--range-start", "--range-end", { row_offset = -1, col_offset = -1 }),
			-- 	"--tab-width",
			-- 	"-1",
			-- 	"--use-tabs",
			-- 	to_stdin = true,
			-- 	dynamic_command = cmd_resolver.from_node_modules(),
			-- 	cwd = h.cache.by_bufnr(function(params)
			-- 		return u.root_pattern(
			-- 			-- https://prettier.io/docs/en/configuration.html
			-- 			".prettierrc",
			-- 			".prettierrc.json",
			-- 			".prettierrc.yml",
			-- 			".prettierrc.yaml",
			-- 			".prettierrc.json5",
			-- 			".prettierrc.js",
			-- 			".prettierrc.cjs",
			-- 			".prettierrc.toml",
			-- 			"prettier.config.js",
			-- 			"prettier.config.cjs",
			-- 			"package.json"
			-- 		)(params.bufname)
			-- 	end),
			-- },
			factory = h.formatter_factory,
		}),
		null_ls.builtins.formatting.shellharden,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.yamlfmt,
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

-- local formatting = null_ls.builtins.formatting
-- null_ls.setup({
-- 	sources = {
-- 		formatting.prettier.with({
-- 			filetypes = { "javascript", "typescript", "html", "css", "json" },
-- 			-- set tab width to 2 and use tabs instead of spaces
-- 			args = { "--stdin-filepath", "$FILENAME", "--tab-width", "1", "--use-tabs" },
-- 		}),
-- 	},
-- })

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
		{ name = "nvim_lua" },
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
	-- cmp.setup.cmdline("/", {
	-- 	mapping = cmp.mapping.preset.cmdline(),
	-- 	sources = {
	-- 		{ name = "buffer" },
	-- 	},
	-- }),

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	-- cmp.setup.cmdline(":", {
	-- 	sources = cmp.config.sources({
	-- 		{ name = "path" },
	-- 	}, {
	-- 		{ name = "cmdline" },
	-- 	}),
	-- }),
})

-- require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })

vim.keymap.set("n", "<leader>ih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
	defaults = {
		defaults = {
			-- layout_config = {
			-- 	preview_cutoff = 250, -- Adjust this value to increase or decrease the size
			-- },
		},
		-- mappings = { default_mappings = config.values.default_mappings },
		history = {
			path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
			limit = 100,
		},
		file_ignore_patterns = { "node_modules/.*" },
	},
})

require("telescope").load_extension("ui-select")
-- require('telescope').load_extension('smart_history')

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

vim.cmd.colorscheme("catppuccin")

vim.api.nvim_create_user_command("Cppath", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command("Tc", function()
	vim.cmd("tabclose")
end, {})

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

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	-- vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	--	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	-- 	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

require("telescope").load_extension("git_worktree")

-- require("ts_context_commentstring").setup({
-- 	enable_autocmd = false,
-- })

local Harpoon = require("harpoon")
Harpoon.setup({
	tabline = true,
	tabline_prefix = " ",
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
		-- tabline = true,
		-- tabline_prefix = " hellow  ",
		-- tabline_suffix = " world  ",
	},
	menu = {
		width = vim.api.nvim_win_get_width(0) - 30,
		height = vim.api.nvim_win_get_height(0) - 18,
	},
})

-- Global variable to store the window ID
_G.my_floating_window_id = nil

-- Function to create a floating window
local function create_floating_window()
	-- Create a new buffer
	local buf = vim.api.nvim_create_buf(false, true) -- {listed: false, scratch: true}

	-- Determine the width and height of the window
	local width = vim.api.nvim_get_option("columns")
	local height = vim.api.nvim_get_option("lines")

	-- Set the dimensions and position of the floating window
	local win_width = math.ceil(width * 0.8)
	local win_height = math.ceil(height * 0.5)
	local row = math.ceil((height - win_height) / 2) - 1
	local col = math.ceil((width - win_width) / 2)

	-- Set the window options
	local opts = {
		style = "minimal",
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		border = "rounded",
	}

	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, opts)

	-- Store the window ID
	_G.my_floating_window_id = win

	-- Optionally, you can set some buffer options
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
		"This is a floating window",
		"You can add any content here",
		"Line 3",
		"Line 4",
	})
end

-- Function to close the floating window

-- Make the functions available globally
_G.create_floating_window = create_floating_window

local function close_floating_window()
	if _G.my_floating_window_id then
		vim.api.nvim_win_close(_G.my_floating_window_id, true)
		_G.my_floating_window_id = nil
	else
		print("No floating window to close")
	end
end

vim.keymap.set("n", "<leader>wy", create_floating_window, {})
vim.keymap.set("n", "<leader>wx", close_floating_window, {})
