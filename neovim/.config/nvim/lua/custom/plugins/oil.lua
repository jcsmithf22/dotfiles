vim.pack.add { 'https://github.com/stevearc/oil.nvim' }
require('oil').setup()

vim.keymap.set('n', '<leader>ec', string.format('<Cmd>Oil %s<CR>', vim.fn.stdpath 'config'), { desc = 'Neovim config directory' })
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
