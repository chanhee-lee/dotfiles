-- return { -- Shows popup with possible keybindings
-- 	"folke/which-key.nvim",
-- 	event = "VimEnter",
-- 	config = function()
-- 		require("which-key").setup()
-- 	end,
-- }

-- return {
-- 		"folke/which-key.nvim",
-- 		event = "VeryLazy", -- Sets the loading event to 'VeryLazy'
-- 		config = function() -- This is the function that runs, AFTER loading
-- 			local wk = require("which-key")
-- 			wk.setup()
--
-- 			-- Document existing key chains
-- 			wk.add({
-- 				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
-- 				["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
-- 				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
-- 				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
-- 				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
-- 			})
-- 		end,
-- 	}
--
return {
  "folke/which-key.nvim",
  event = "VeryLazy",  -- Lazy load on event
  opts = {
    -- Use `opts.win` instead of the deprecated `opts.window`
    win = {
      border = "single",  -- Customize which-key window border
    },
    -- Any other configuration options you might have
    plugins = {
      spelling = { enabled = true },  -- Example plugin configuration
    },
  },
  keys = {
    {
      "<leader>?",  -- Register <leader>? keybinding
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",  -- Description
    },
    -- Example of grouped keymaps
    {
      "<leader>c", name = "[C]ode", _ = "which_key_ignore",
    },
    {
      "<leader>d", name = "[D]ocument", _ = "which_key_ignore",
    },
    {
      "<leader>r", name = "[R]ename", _ = "which_key_ignore",
    },
    {
      "<leader>s", name = "[S]earch", _ = "which_key_ignore",
    },
    {
      "<leader>w", name = "[W]orkspace", _ = "which_key_ignore",
    },
  }
}
