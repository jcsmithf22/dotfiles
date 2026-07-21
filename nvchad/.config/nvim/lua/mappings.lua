require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

map("t", "<C-h>", "<Cmd>wincmd h<CR>", { desc = "terminal window left" })
map("t", "<C-j>", "<Cmd>wincmd j<CR>", { desc = "terminal window down" })
map("t", "<C-k>", "<Cmd>wincmd k<CR>", { desc = "terminal window up" })
map("t", "<C-l>", "<Cmd>wincmd l<CR>", { desc = "terminal window right" })
