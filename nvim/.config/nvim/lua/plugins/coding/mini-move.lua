return { -- moving selected text
	"echasnovski/mini.move",
	version = "*",
	keys = {
		{ "<C-h>", desc = "Move selection left", mode = { "n", "v" } },
		{ "<C-l>", desc = "Move selection right", mode = { "n", "v" } },
		{ "<C-j>", desc = "Move selection down", mode = { "n", "v" } },
		{ "<C-k>", desc = "Move selection up", mode = { "n", "v" } },
	},
	opts = {
		mappings = {
			left = "<C-h>",
            right = "<C-l>",
			down = "<C-j>",
			up = "<C-k>",
			line_left = "<C-h>",
			line_right = "<C-l>",
			line_down = "<C-j>",
			line_up = "<C-k>",
		},
	},
}