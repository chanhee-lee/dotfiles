return { -- For layer information
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
    ensure_installed = { "bash", "c", "html", "lua", "luadoc", "markdown", "vim", "vimdoc" },
	opts = {
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}