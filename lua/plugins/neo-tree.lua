return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local NeoTreeGitStatus = function(opt)
			local cmd = "Neotree float git_status git_base=" .. opt.args
			print(cmd)
			vim.api.nvim_command(cmd)
			return 0
		end

		vim.api.nvim_create_user_command("Ngs", NeoTreeGitStatus, { nargs = "?" })

		------------------------------- keymap for neo-tree -------------------------------
		vim.keymap.set("n", "<leader>p", ":Neotree<CR>", { silent = true })
		vim.keymap.set("n", "<leader>ng", ":Neotree float git_status<CR>", { silent = true })
		vim.keymap.set("n", "<c-t>", ":Neotree source=filesystem reveal left toggle=true<CR>", { silent = true })
		vim.keymap.set(
			"n",
			"<leader>nb",
			":Neotree float git_status git_base=" .. vim.fn.system("git branch --show-current") .. "<CR>",
			{}
		)
		-----------------------------------------------------------------------------------
	end,
}
