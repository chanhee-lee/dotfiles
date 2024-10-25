vim.g.disable_b_plugin = true  -- Disable bufferline
return {
	{ import = "plugins.ui" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.editor", exclude = { "plugins.editor.bufferline" } },
	{ import = "plugins.directory" },
	{ import = "plugins.coding" },
	{ import = "plugins.formatter" },
	{ import = "plugins.lsp" },
	{ import = "plugins.lint" },
	{ import = "plugins.util" },
	{ import = "plugins.misc" },
}
