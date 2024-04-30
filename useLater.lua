--require("nvim-treesitter.configs").setup({
--	textobjects = {
--		select = {
--			enable = true,

--			-- Automatically jump forward to textobj, similar to targets.vim
--			lookahead = true,

--			keymaps = {
--				-- You can use the capture groups defined in textobjects.scm
--				["af"] = "@function.outer",
--				["if"] = "@function.inner",
--				["ac"] = "@class.outer",
--				-- You can optionally set descriptions to the mappings (used in the desc parameter of
--				-- nvim_buf_set_keymap) which plugins like which-key display
--				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
--				-- You can also use captures from other query groups like `locals.scm`
--				["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
--				["ik"] = "@conditional.inner",
--				["ak"] = "@conditional.outer",
--				["il"] = "@loop.inner",
--				["al"] = "@loop.outer",
--			},
--			-- You can choose the select mode (default is charwise 'v')
--			--
--			-- Can also be a function which gets passed a table with the keys
--			-- * query_string: eg '@function.inner'
--			-- * method: eg 'v' or 'o'
--			-- and should return the mode ('v', 'V', or '<c-v>') or a table
--			-- mapping query_strings to modes.
--			selection_modes = {
--				["@parameter.outer"] = "v", -- charwise
--				["@function.outer"] = "V", -- linewise
--				["@class.outer"] = "<c-v>", -- blockwise
--			},
--			-- If you set this to `true` (default is `false`) then any textobject is
--			-- extended to include preceding or succeeding whitespace. Succeeding
--			-- whitespace has priority in order to act similarly to eg the built-in
--			-- `ap`.
--			--
--			-- Can also be a function which gets passed a table with the keys
--			-- * query_string: eg '@function.inner'
--			-- * selection_mode: eg 'v'
--			-- and should return true or false
--			include_surrounding_whitespace = true,
--		},
--	},
--})

-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	callback = function()
-- 		vim.lsp.start({
-- 			name = "flutter_lsp",
-- 			cmd = { "home/antony/flutter/bin/dart" },
-- 			root_dir = vim.fn.getcwd(),
-- 		})
-- 	end,
-- })

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

-- function Harpoon_files()
-- 	local contents = {}
-- 	local marks_length = harpoon:list():length()
-- 	local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
-- 	for index = 1, marks_length do
-- 		local harpoon_file_path = harpoon:list():get(index).value
-- 		local file_name = harpoon_file_path == "" and "(empty)" or vim.fn.fnamemodify(harpoon_file_path, ":t")

-- 		if current_file_path == harpoon_file_path then
-- 			contents[index] = string.format("%%#HarpoonNumberActive# %s. %%#HarpoonActive#%s ", index, file_name)
-- 		else
-- 			contents[index] = string.format("%%#HarpoonNumberInactive# %s. %%#HarpoonInactive#%s ", index, file_name)
-- 		end
-- 	end

-- 	return table.concat(contents)
-- end

-- local M = {}
-- local function get_color(group, attr)
-- 	return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
-- end

-- local tabs = shorten_filenames(require("harpoon").get_mark_config().marks)
-- local Index = require("harpoon.mark").get_index_of(vim.fn.bufname())
-- InnObj = {}
-- for k, v in pairs(tabs) do
-- 	InnObj[k] = function()
-- 		return tabs[k].filename
-- 	end
-- end
function Taber()
	local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
	local tabs = (require("harpoon").get_mark_config().marks)
	vim.print("TABS------------->>>>>>>", tabs)
	local index = require("harpoon.mark").get_index_of(vim.fn.bufname())
	local InnObj = {}
	for k, v in pairs(tabs) do
		InnObj[k] = {
			function()
				local index = require("harpoon.mark").get_index_of(vim.fn.bufname())
				vim.fn.bufname()
				local path = string.format(" %s ", tabs[k].filename)
				if path == current_file_path then
					return "hello"
				else
					return path
				end
			end,
			component = { right = "" },
		}
	end
	return InnObj
end

-- function Taber_2()
-- 	return {
-- 		function()
-- 			local vi = (vim.fn.fnamemodify(vim.fn.expand("%:p"), ":."))
-- 			return vi
-- 		end,
-- 		color = { bg = colors.blue },
-- 	}
-- end

-- function Header()
-- 	return {
-- 		-- "filename",
-- 		function()
-- 			return string.format(vim.fn.bufname())
-- 		end,
-- 		color = { bg = colors.blue },
-- 		separator = {
-- 			right = "",
-- 		},
-- 	}
-- end

-- function M.setup(opts)
-- 	function _G.tabline()
-- 		local tabs = shorten_filenames(require("harpoon").get_mark_config().marks)
-- 		local tabline = ""

-- 		local index = require("harpoon.mark").get_index_of(vim.fn.bufname())

-- 		for i, tab in ipairs(tabs) do
-- 			local is_current = i == index

-- 			local label

-- 			if tab.filename == "" or tab.filename == "(empty)" then
-- 				label = "(empty)"
-- 				is_current = false
-- 			else
-- 				label = tab.filename
-- 			end

-- 			if is_current then
-- 				tabline = tabline
-- 					.. "%#HarpoonNumberActive#"
-- 					.. (opts.tabline_prefix or "   ")
-- 					.. i
-- 					.. " %*"
-- 					.. "%#HarpoonActive#"
-- 			else
-- 				tabline = tabline
-- 					.. "%#HarpoonNumberInactive#"
-- 					.. (opts.tabline_prefix or "   ")
-- 					.. i
-- 					.. " %*"
-- 					.. "%#HarpoonInactive#"
-- 			end

-- 			tabline = tabline .. label .. (opts.tabline_suffix or "   ") .. "%*"

-- 			if i < #tabs then
-- 				tabline = tabline .. "%T"
-- 			end
-- 		end

-- 		return tabline
-- 	end

-- 	vim.opt.showtabline = 2

-- 	vim.o.tabline = "%!v:lua.tabline()"

-- 	vim.api.nvim_create_autocmd("ColorScheme", {
-- 		group = vim.api.nvim_create_augroup("harpoon", { clear = true }),
-- 		pattern = { "*" },
-- 		callback = function()
-- 			local color = get_color("HarpoonActive", "bg#")

-- 			if color == "" or color == nil then
-- 				vim.api.nvim_set_hl(0, "HarpoonInactive", { link = "Tabline" })
-- 				vim.api.nvim_set_hl(0, "HarpoonActive", { link = "TablineSel" })
-- 				vim.api.nvim_set_hl(0, "HarpoonNumberActive", { link = "TablineSel" })
-- 				vim.api.nvim_set_hl(0, "HarpoonNumberInactive", { link = "Tabline" })
-- 			end
-- 		end,
-- 	})

-- 	log.debug("setup(): Tabline Setup", opts)
-- end

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


-- local function shorten_filenames(filenames)
-- 	local shortened = {}

-- 	local counts = {}
-- 	for _, file in ipairs(filenames) do
-- 		local name = vim.fn.fnamemodify(file.filename, ":t")
-- 		counts[name] = (counts[name] or 0) + 1
-- 	end

-- 	for _, file in ipairs(filenames) do
-- 		local name = vim.fn.fnamemodify(file.filename, ":t")

-- 		if counts[name] == 1 then
-- 			table.insert(shortened, { filename = vim.fn.fnamemodify(name, ":t") })
-- 		else
-- 			table.insert(shortened, { filename = file.filename })
-- 		end
-- 	end

-- 	return shortened
-- end
-- function tprint(tbl, indent)
-- 	if not indent then
-- 		indent = 0
-- 	end
-- 	local toprint = string.rep(" ", indent) .. "{\r\n"
-- 	indent = indent + 2
-- 	for k, v in pairs(tbl) do
-- 		toprint = toprint .. string.rep(" ", indent)
-- 		if type(k) == "number" then
-- 			toprint = toprint .. "[" .. k .. "] = "
-- 		elseif type(k) == "string" then
-- 			toprint = toprint .. k .. "= "
-- 		end
-- 		if type(v) == "number" then
-- 			toprint = toprint .. v .. ",\r\n"
-- 		elseif type(v) == "string" then
-- 			toprint = toprint .. '"' .. v .. '",\r\n'
-- 		elseif type(v) == "table" then
-- 			toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
-- 		else
-- 			toprint = toprint .. '"' .. tostring(v) .. '",\r\n'
-- 		end
-- 	end
-- 	toprint = toprint .. string.rep(" ", indent - 2) .. "}"
-- 	return toprint
-- end
--
--
--
-- Color table for highlights
-- stylua: ignore
-- local colors = {
-- 	bg          = '#202328',
-- 	fg          = '#bbc2cf',
-- 	yellow      = '#ECBE7B',
-- 	p_yellow    = '#e4f00e',
-- 	cyan        = '#008080',
-- 	darkblue    = '#081633',
-- 	green       = '#98be65',
-- 	orange      = '#FF8800',
-- 	violet      = '#a9a1e1',
-- 	magenta     = '#c678dd',
-- 	blue        = '#51afef',
-- 	red         = '#ec5f67',
-- 	black       = '#090a04',
-- 	grey        = '#a0a1a7',
-- 	white       = '#f3f3f3',
-- 	light_green = '#83a598',
-- }

