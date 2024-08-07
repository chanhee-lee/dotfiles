-- NVIM basic configurations
local o = vim.opt

o.number = true -- Show line numbers
o.relativenumber = true -- Show relative line numbers

o.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
o.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing operations
o.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
o.expandtab = true -- Use spaces instead of tabs
o.smartindent = true -- Do smart autoindenting when starting a new line
o.wrap = false -- Display long lines as just one line

--o.swapfile = false -- Disable swap file
--o.backup = false -- Disable backup file
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true --Save undo history

o.hlsearch = true --false
o.incsearch = true -- Highlight search results as you type

o.termguicolors = true -- Enable 24-bit RGB color in the TUI

o.scrolloff = 8 -- Minimum number of screen lines to keep above and below the cursor
o.signcolumn = "yes" -- Signs on column
o.isfname:append("@-@") -- Add @ to isfname (valid file names)

o.updatetime = 50 -- Faster completion

o.ignorecase = true -- Ignore case when searching
o.smartcase = true -- Override the 'ignorecase' if search pattern contains upper case characters or \

-- NVIM Additional Configs 
o.mouse = "a" -- Enable mouse support
o.clipboard = "unnamedplus" -- Use system clipboard
o.inccommand = "nosplit" -- Show live preview of command substitution
o.cursorline = true -- Highlight the current line