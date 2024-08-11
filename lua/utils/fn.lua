local popup = require("plenary.popup")
local M = {}

M.taber = function()
	local tabs = require("harpoon").get_mark_config().marks
	local returnObj = {}
	local index = require("harpoon.mark")
	vim.print(index)
	for k, v in pairs(tabs) do
		returnObj[k] = {
			function()
				return v["filename"]
			end,
		}
	end
	-- vim.print(returnObj)
	return returnObj
end

M.create_window = function(content)
	-- Create a new buffer
	local buf = vim.api.nvim_create_buf(false, true) -- {listed: false, scratch: true}

	-- Determine the width and height of the window
	local width = vim.api.nvim_get_option_value("columns", {})
	local height = vim.api.nvim_get_option_value("lines", {})

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
		focusable = false,
		border = { { "╭" }, { "─" }, { "╮" }, { "│" }, { "╯" }, { "─" }, { "╰" }, { "│" } },
	}

	-- Create the floating window
	vim.api.nvim_open_win(buf, true, opts)

	-- Optionally, you can set some buffer options
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
end

M.create_window_with_title = function(title, content, modifiable)
	local width = 90
	local height = 12
	local bufnr = vim.api.nvim_create_buf(false, true)
	local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

	vim.api.nvim_set_hl(0, "TitleWinBorder", { bg = nil, fg = "#3cb9fc" })

	local Popup_win_id, win = popup.create(bufnr, {
		title = title,
		line = math.floor(((vim.o.lines - height) / 1.8) - 1),
		col = math.floor((vim.o.columns - width) / 2),
		minwidth = width,
		minheight = height,
		borderchars = borderchars,
		highlight = "NormalFloat",
		borderhighlight = "TitleWinBorder",
		focusable = false,
	})

	-- vim.api.nvim_win_set_option(win.border.win_id, "winhl", "Normal:HarpoonBorder")

	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = bufnr })
	vim.api.nvim_set_option_value("modifiable", modifiable or false, { buf = bufnr })

	return {
		win = win,
		bufnr = bufnr,
		win_id = Popup_win_id,
	}
end

return M
