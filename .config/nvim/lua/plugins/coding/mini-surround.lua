return {
	"echasnovski/mini.surround",
	keys = {
		{ "msa", desc = "Add surrounding", mode = { "n", "v" } },
		{ "msd", desc = "Delete surrounding" },
		{ "msf", desc = "Find right surrounding" },
		{ "msF", desc = "Find left surrounding" },
		{ "msh", desc = "Highlight surrounding" },
		{ "msr", desc = "Replace surrounding" },
		{ "msn", desc = "Update `Minisurround.config.n_lines`" },
	},
	opts = {
		mappings = {
			add = "msa",
			delete = "msd",
			find = "msf",
			find_left = "msF",
			highlight = "msh",
			replace = "msr",
			update_n_lines = "msn",
		},
	},
}