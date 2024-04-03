return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
		on_attach = function(buffer)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
			end

			map("n", "]h", gs.next_hunk, "Next hunk")
			map("n", "[h", gs.prev_hunk, "Previous hunk")
			map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
			map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
			map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
			map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
			map("n", "<leader>ghR", gs.reset_buffer, "Reset Hunk")
			map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
			map("n", "<leader>gtd", gs.toggle_deleted, "Toggle Deleted")
			map("n", "<leader>ghb", function()
				gs.blame_line({ full = true })
			end, "Blame Line")
			map("n", "<leader>ghB", function()
				gs.toggle_current_line_blame()
			end, "Toggle Current Line Blame")
			map("n", "<leader>ghd", gs.diffthis, "Diff This")
			map("n", "<leader>ghx", "<cmd>wincmd p | q<cr>", "Exit Diff")
			map("n", "<leader>ghD", function()
				gs.diffthis("~")
			end, "Diff This ~")
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select Hunk")
		end,
	},
}
