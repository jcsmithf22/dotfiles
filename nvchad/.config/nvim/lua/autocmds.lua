require "nvchad.autocmds"

-- Auto startinsert when focusing any terminal
vim.api.nvim_create_autocmd({ "TermOpen", "BufWinEnter", "WinEnter" }, {
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
  end,
})
