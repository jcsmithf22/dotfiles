local M = {}

---@type Everforest.SetupOptions
M.config = {
  background = 'hard',
}

function M.setup()
  require('everforest').setup(M.config)

  vim.o.background = 'dark'
  vim.cmd.colorscheme 'everforest'
end

return M
