return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
	keys = {
		{
			"<leader>rl",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "[R]estore [L]ast Session",
		},
		{
			"<leader>rs",
			function()
				require("persistence").load()
			end,
			desc = "[R]estore [S]ession",
		},
	},
}