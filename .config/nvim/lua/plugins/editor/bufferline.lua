return 
	{ -- Tabs
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		-- keys = { -- just in time loading by lazy
		-- 	{ "<leader>bmn", ":BufferLineMoveNext<CR>", desc = "[b]uffer [m]ove to [n]ext buffer" },
		-- 	{ "<leader>bmp", ":BufferLineMovePrev<CR>", desc = "[b]uffer [m]ove to [p]revious buffer" },
		-- },
		config = function()
			vim.opt.termguicolors = true
			require("bufferline").setup({
				options = { -- Add Pinned icon
					groups = {
						items = {
							require('bufferline.groups').builtin.pinned:with({ icon = "" })
						}
						-- Optionally, you can define more group configurations here
					},
					numbers = "none",  -- Options: "none", "ordinal", "buffer_id", "both"
					close_command = function(n) return string.format("bdelete %d", n) end,
					right_mouse_command = function(n) return string.format("bdelete %d", n) end,
					left_mouse_command = function(n) return string.format("buffer %d", n) end,
					buffer_close_icon = '',
					modified_icon = '●',
					close_icon = '',
					left_trunc_marker = '',
					right_trunc_marker = '',
				}
			})
			-- key mapping - immediate loading
			vim.api.nvim_set_keymap('n', '<leader>bn', ':BufferLineMoveNext<CR>', { noremap = true, silent = true, desc = "[b]uffer move to [n]ext buffer" })
			vim.api.nvim_set_keymap('n', '<leader>bp', ':BufferLineMovePrev<CR>', { noremap = true, silent = true, desc = "[b]uffer move to [p]revious buffer"})
			vim.api.nvim_set_keymap('n', '<leader>bP', ':BufferLineTogglePin<CR>', { noremap = true, silent = true, desc = "[b]uffer [P]in" })
		end,
	}
