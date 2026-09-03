-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "\\", ":Neotree reveal<CR>", { desc = "NeoTree reveal" } },
	},
	opts = {
		filesystem = {
			window = {
				mappings = {
					["\\"] = "close_window",
					-- A single Enter press can arrive as two <CR> keystrokes a
					-- few ms apart (terminal/OS key-repeat), and since <cr>
					-- toggles a directory, the second one immediately
					-- re-collapses what the first one just opened -- visible
					-- as the node opening and closing at the same time. Drop
					-- any <cr> that follows the last one by less than 150ms.
					["<cr>"] = function(state)
						local now = vim.uv.hrtime()
						local last = state.__last_cr_ns or 0
						state.__last_cr_ns = now
						if (now - last) < 150 * 1e6 then
							return
						end
						require("neo-tree.sources.filesystem.commands").open(state)
					end,
				},
			},
		},
	},
}
