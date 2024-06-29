return {
	"nvim-lualine/lualine.nvim",
	-- event = "VeryLazy",
	-- lazy = true,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local colors = {
			bg = "#202328",
			fg = "#bbc2cf",
			yellow = "#ECBE7B",
			p_yellow = "#e4f00e",
			cyan = "#008080",
			darkblue = "#081633",
			green = "#98be65",
			orange = "#FF8800",
			violet = "#a9a1e1",
			magenta = "#c678dd",
			blue = "#51afef",
			red = "#ec5f67",
			black = "#090a04",
			grey = "#a0a1a7",
			white = "#f3f3f3",
			light_green = "#83a598",
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
				section_separators = { left = "", right = "" }, --         
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
					-- { "harpoon_status", icon = " " },
					-- project_root,
					-- 	{ "filename", file_status = true, newfile_status = true, path = 1 },
				}, --lualine_x = {},
				lualine_x = {
					{
						function()
							-- 󰨑  󰤼    󰻭  󱇿  󰝜  󰩵    󱂬  󱓺  󰓪  󰱾  󱀂  󱀃  󰹈    󰧑
							-- 󰼏  󰼐  󰼑  󰼒  󰼓  󰼔  󰼕  󰼖  󰼗  󰼘  󰿪
							local Icon = "󰂽 " -- 󱗖  󱉟  󰗚  󰂾        󰭣  󰂽
							if #vim.api.nvim_list_tabpages() > 1 then
								return (Icon .. vim.fn.tabpagenr() .. "|" .. (#vim.api.nvim_list_tabpages()))
							else
								return ""
							end
						end,
						color = function()
							if #vim.api.nvim_list_tabpages() > 1 then
								return { fg = "#89CFF0", gui = "bold" }
							else
								return { fg = "grey", gui = "bold" }
							end
						end,

						padding = { left = 1, right = 1 },
					},
					{
						function()
							-- 󰨑  󰤼    󰻭    󱇿  󰝜  󰩵  󱓺  󰓪  󰱾  󱀂  󱀃  󰹈    󰧑
							-- 󰼏  󰼐  󰼑  󰼒  󰼓  󰼔  󰼕  󰼖  󰼗  󰼘  󰿪
							local Icon = "󱇿 "
							-- if #vim.api.nvim_list_wins() == 1 then
							-- 	Icon = "󰼏 "
							-- elseif #vim.api.nvim_list_wins() == 2 then
							-- 	Icon = "󰼐 "
							-- elseif #vim.api.nvim_list_wins() == 3 then
							-- 	Icon = "󰼑 "
							-- end
							if #vim.api.nvim_list_tabpages() == 1 then
								return (Icon .. vim.fn.winnr() .. "|" .. #vim.api.nvim_tabpage_list_wins(0))
							else
								return (
									Icon
									.. vim.fn.winnr()
									.. "|"
									.. (#vim.api.nvim_tabpage_list_wins(0))
									.. "|"
									.. (#vim.api.nvim_list_wins())
								)
							end
						end,
						color = {
							fg = "#a9ff0a",
							gui = "bold",
						},
						padding = { left = 1, right = 1 },
					},
					{
						"filetype",
						padding = { left = 1, right = 1 },
					},
					{
						"fileformat",
						padding = { left = 1, right = 2 },
					},
				},
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
			-- 	lualine_a = { Header() },
			-- 	lualine_b = { Taber_2() },
			-- 	lualine_c = { bg = nil, guibg = nil },
			-- 	lualine_z = { bg = nil, guibg = nil },
			-- 	lualine_y = { bg = nil, guibg = nil },
			-- 	lualine_x = { bg = nil, guibg = nil },
			-- },
		}

		-- Config

		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- Inserts a component in lualine_x at right section
		-- local function ins_right(component)
		-- 	table.insert(config.sections.lualine_x, component)
		-- end

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
			-- Lsp server name .
			function()
				local msg = "No Active Lsp"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_clients()
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
			icon = "", --               󰍶  󰍵      󰦓
			color = { fg = "#ffffff", gui = "bold" },
			-- color = { fg = colors.green, gui = "bold" },
		})

		-- ins_right({
		-- 	function()
		-- 		return ("[" .. vim.fn.winnr() .. "]")
		-- 	end,
		-- })

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
	end,
}
