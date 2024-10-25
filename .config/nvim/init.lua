require("core.keymaps")
require("core.options")
require("core.lazy")
require("core.yank-highlight")
-- Set file encoding to UTF-8
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.fileencodings = "utf-8"
vim.opt.clipboard:append("unnamedplus") -- Use the '+' register for the clipboard
