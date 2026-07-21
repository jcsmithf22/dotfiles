require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Restore latest cursor position on file open
MiniMisc.setup_restore_cursor()

-- Synchronize terminal emulator background with Neovim's background to remove
-- possibly different color padding around Neovim instance
MiniMisc.setup_termbg_sync()

MiniMisc.setup_auto_root { ".git", "Makefile", "lazy-lock.json" }
