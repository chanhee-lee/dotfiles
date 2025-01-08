-- return {
-- 	"stevearc/conform.nvim",
-- 	opts = {
-- 		notify_on_error = false,
-- 		format_on_save = function(bufnr)
-- 			local disable_filetypes = { c = true, cpp = true, python = true }
-- 			return {
-- 				timeout_ms = 500,
-- 				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
-- 			}
-- 		end,
-- 		formatters_by_ft = {
-- 			lua = { "stylua" },
-- 			-- rust = { "rustfmt" },
-- 			-- javascript = { "prettierd" },
-- 			-- javascriptreact = { "prettierd" },
-- 			-- typescript = { "prettierd" },
-- 			-- typescriptreact = { "prettierd" },
-- 			-- python = { "ruff_format" },
-- 		},
-- 	},
-- 	keys = {
-- 		{
-- 			"<leader>cf",
-- 			function()
-- 				require("conform").format()
-- 			end,
-- 			desc = "[C]ode [F]ormat",
-- 		},
-- 	},
-- }

return {
	"stevearc/conform.nvim",
	opts = {
		format = {
			timeout_ms = 3000,
			async = true,
			quiet = false,
			lsp_fallback = true,
		},
		notify_on_error = true,
		format_on_save = function(bufnr)
			local ignore_filetypes = { "python" } -- Add here to disable format on save
			if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
				return
			end
			return {
				timeout_ms = 500,
				lsp_fallback = "fallback",
			}
		end,
		formatters_by_ft = { -- Which formatters to use for which filetypes
			lua = { "stylua" },
			rust = { "rustfmt" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			astro = { "prettierd" },
			python = { "ruff_format", "ruff_organize_imports" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			cs = { "csharpier" },
			ruby = { "rubocop" },
			go = { "gofmt", "goimports" },
			templ = { "templ" },
			json = { "fixjson" },
			jsonc = { "fixjson" },
			toml = { "taplo" },
		},
		formatters = {
			csharpier = {
				command = "dotnet-csharpier",
				args = { "--write-stdout" },
			},
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
