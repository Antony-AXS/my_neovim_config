return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "gr", ":Git refresh<CR>", {})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
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
					delay = 550,
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
					---------------------------------- GIT Signs -------------------------------------
					vim.keymap.set("n", "<leader>hp", gs.preview_hunk)
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end, {})
					vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, {})
					vim.keymap.set("n", "<leader>hd", gs.diffthis, {})
					vim.keymap.set("n", "<leader>td", gs.toggle_deleted, {})
					vim.keymap.set("n", "<leader>hD", function()
						gs.diffthis("~")
					end, {})

					-- Text object
					vim.keymap.set({ "o", "x" }, "<leader>ih", ":<C-U>Gitsigns select_hunk<CR>", {})
					----------------------------------------------------------------------------------
				end,
			})
		end,
	},
	{
		"ThePrimeagen/git-worktree.nvim",
		config = function()
			local Worktree = require("git-worktree")

			-- op = Operations.Switch, Operations.Create, Operations.Delete
			-- metadata = table of useful values (structure dependent on op)
			--      Switch
			--          path = path you switched to
			--          prev_path = previous worktree path
			--      Create
			--          path = path where worktree created
			--          branch = branch name
			--          upstream = upstream remote name
			--      Delete
			--          path = path where worktree deleted

			Worktree.on_tree_change(function(op, metadata)
				if op == Worktree.Operations.Switch then
					print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
				end
			end)

			local deleteWorkTree = function(opts_del)
				local cmd = "lua require('git-worktree').delete_worktree('" .. opts_del.args .. "')"
				print(cmd)
				vim.api.nvim_command(cmd)
				return 0
			end

			vim.api.nvim_create_user_command("Gwdel", deleteWorkTree, { nargs = "?" })
			----------------------------- keymap for Git WorkTree ----------------------------
			-- Creates a worktree.  Requires the path, branch name, and the upstream
			vim.keymap.set(
				"n",
				"<leader>gt",
				":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
				{}
			)

			-- switches to an existing worktree.  Requires the path name
			vim.keymap.set(
				"n",
				"<leader>gh",
				":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
				{}
			)

			-- deletes to an existing worktree.  Requires the path name
			--vim.keymap.set("n", "<leader>gf", require("git-worktree").delete_worktree(), {})
			----------------------------------------------------------------------------------

			Worktree.setup({
				change_directory_command = "cd",
				update_on_change = true,
				update_on_change_command = "e .",
				clearjumps_on_change = true,
				autopush = false,
			})
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
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
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = function()
			-- local neogit = require("neogit")
			-- neogit.setup({})
			------------------------ keymap for NeoGit and DiffView ----------------------
			vim.keymap.set("n", "<leader>nf", ":Neogit kind=floating<CR>", {})
			vim.keymap.set("n", "<leader>nd", ":DiffviewOpen<CR>", {})
			vim.keymap.set("n", "<leader>nt", ":DiffviewToggleFiles<CR>", {})
			vim.keymap.set("n", "<leader>nc", ":DiffviewClose<CR>", {})
			vim.keymap.set("n", "<leader>nh", ":DiffviewFileHistory<CR>", {})
			vim.keymap.set("n", "<leader>nq", ":DiffviewFileHistory %<CR>", {})
			vim.keymap.set("n", "<leader>nl", ":DiffviewLogs<CR>", {})
			vim.keymap.set("n", "<leader>ns", ":Neogit kind=split_above<CR>", {})
			------------------------------------------------------------------------------
		end,
		-- lazy = true,
	},
}
