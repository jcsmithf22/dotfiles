vim.pack.add { { src = 'https://github.com/mrcjkb/rustaceanvim', version = vim.version.range '^9' } }

vim.api.nvim_create_autocmd('BufRead', {
  pattern = 'Cargo.toml',
  once = true,
  callback = function()
    vim.pack.add { 'https://github.com/saecki/crates.nvim' }
    require('crates').setup {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    }
  end,
})
