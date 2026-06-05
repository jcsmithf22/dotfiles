-- Add Astro TypeScript plugin to vtsls for cross-file type support
-- This enables .ts/.tsx files to understand types when importing .astro components

local astro_ts_plugin_path

-- Try Mason's install location first
local mason_pkg = vim.fn.stdpath 'data' .. '/mason/packages/astro-language-server/node_modules/@astrojs/ts-plugin'
if vim.fn.isdirectory(mason_pkg) == 1 then
  astro_ts_plugin_path = mason_pkg
else
  vim.notify(
    '[vtsls] @astrojs/ts-plugin not found. Install via Mason (`:MasonInstall astro-language-server`) or npm (`npm i -g @astrojs/ts-plugin`).',
    vim.log.levels.WARN
  )
end

return {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = astro_ts_plugin_path and {
          {
            name = '@astrojs/ts-plugin',
            location = astro_ts_plugin_path,
            enableForWorkspaceTypeScriptVersions = true,
          },
        } or nil,
      },
    },
  },
}
