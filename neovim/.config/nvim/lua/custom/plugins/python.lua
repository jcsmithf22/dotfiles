vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  once = true,
  callback = function()
    vim.pack.add { 'https://github.com/linux-cultist/venv-selector.nvim' }

    require('venv-selector').setup {
      options = {
        notify_user_on_venv_activation = true,
        override_notify = false,
      },
    }
  end,
})
