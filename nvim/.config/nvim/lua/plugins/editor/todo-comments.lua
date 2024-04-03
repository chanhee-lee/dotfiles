return {
	"folke/todo-comments.nvim",
	cmd = { "TodoTrouble", "TodoTelescope" },
	event = { "BufReadPost", "BufNewFile" },
	config = true,
    -- TODO: Hihihi
    -- FIXME: KJKJKJ
    -- FIX: nasdf
    -- HACK: kjsdf
    -- INFO: kjasdkfj
    -- NOTE: Kjalksdjf
    -- WARN: KJlaksdjflkjs
	keys = {
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next todo comment",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Prevous todo comment",
		},
		{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
		{ "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
		{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo (Telescope)" },
		{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Telescope)" },
	},
}
-- { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },