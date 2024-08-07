return {
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true, python = true }
			return {
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			-- rust = { "rustfmt" },
			-- javascript = { "prettierd" },
			-- javascriptreact = { "prettierd" },
			-- typescript = { "prettierd" },
			-- typescriptreact = { "prettierd" },
			-- python = { "ruff_format" },
		},
	},
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format()
			end,
			desc = "[C]ode [F]ormat",
		},
	},
}