return {
	"nvim-tree/nvim-tree.lua",
    -- cond = false, -- This means disabled
	lazy = false,
	keys = {
		{ "<leader>fe", ":NvimTreeToggle<cr>", desc = "[F]ile [E]xplorer" },
	},
	opts = {
		sort_by = "case_sensitive",
		renderer = {
			group_empty = true,
		},
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
	},
    config = function (_, opts)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        require("nvim-tree").setup(opts)
    end
}