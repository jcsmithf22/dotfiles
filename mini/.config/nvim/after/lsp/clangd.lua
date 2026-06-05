local is_windows = vim.loop.os_uname().sysname:match 'Windows'
return {
  cmd = {
    'clangd',
    is_windows and '--query-driver=C:/Users/JSmith/w64devkit/bin/gcc.exe' or nil,
  },
}
