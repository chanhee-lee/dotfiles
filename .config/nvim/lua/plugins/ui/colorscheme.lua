-- GitHub Dark (default): the same Primer palette as ~/.config/alacritty, ~/.tmux.conf and the
-- plan-board status row. Switched from tokyonight 2026-11-03.
return {
	"projekt0n/github-nvim-theme",
	name = "github-theme",
	lazy = false,
	priority = 1000,
	opts = {
		options = {
			transparent = true,
			styles = {
				comments = "italic",
			},
		},
	},
	config = function(_, opts)
		require("github-theme").setup(opts)
		vim.cmd.colorscheme("github_dark_default")
	end,
}
