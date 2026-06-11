vim.pack.add {
  'https://github.com/sphamba/smear-cursor.nvim',
}

require('smear_cursor').setup {
  -- Your options
  cursor_color = "#868D96"
  -- legacy_computing_symbols_support = true,

  -- cursor_color = '#ff4000',
  -- particles_enabled = true,
  -- particle_max_num = 200,
  -- stiffness = 0.5,
  -- trailing_stiffness = 0.2,
  -- trailing_exponent = 5,
  -- damping = 0.6,
  -- gradient_exponent = 0,
}
