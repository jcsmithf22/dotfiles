-- ┌─────────────────────────┐
-- │ Plugins outside of MINI │
-- └─────────────────────────┘
--
-- This file contains installation and configuration of plugins outside of MINI.
-- They significantly improve user experience in a way not yet possible with MINI.
-- These are mostly plugins that provide programming language specific behavior.
--
-- Use this file to install and configure other such plugins.

-- Make concise helpers for installing/adding plugins in two stages
local add = vim.pack.add
local now_if_args, later = Config.now_if_args, Config.later

-- Tree-sitter ================================================================

-- Tree-sitter is a tool for fast incremental parsing. It converts text into
-- a hierarchical structure (called tree) that can be used to implement advanced
-- and/or more precise actions: syntax highlighting, textobjects, indent, etc.
--
-- Tree-sitter support is built into Neovim (see `:h treesitter`). However, it
-- requires two extra pieces that don't come with Neovim directly:
-- - Language parsers: programs that convert text into trees. Some are built-in
--   (like for Lua), 'nvim-treesitter' provides many others.
--   NOTE: It requires third party software to build and install parsers.
--   See the link for more info in "Requirements" section of the MiniMax README.
-- - Query files: definitions of how to extract information from trees in
--   a useful manner (see `:h treesitter-query`). 'nvim-treesitter' also provides
--   these, while 'nvim-treesitter-textobjects' provides the ones for Neovim
--   textobjects (see `:h text-objects`, `:h MiniAi.gen_spec.treesitter()`).
--
-- Add these plugins now if file (and not 'mini.starter') is shown after startup.
--
-- Troubleshooting:
-- - Run `:checkhealth vim.treesitter nvim-treesitter` to see potential issues.
-- - In case of errors related to queries for Neovim bundled parsers (like `lua`,
--   `vimdoc`, `markdown`, etc.), manually install them via 'nvim-treesitter'
--   with `:TSInstall <language>`. Be sure to have necessary system dependencies
--   (see MiniMax README section for software requirements).
now_if_args(function()
  -- Define hook to update tree-sitter parsers after plugin is updated
  local ts_update = function() vim.cmd 'TSUpdate' end
  Config.on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')

  add {
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  }

  -- Define languages which will have parsers installed and auto enabled
  -- After changing this, restart Neovim once to install necessary parsers. Wait
  -- for the installation to finish before opening a file for added language(s).
  local languages = {
    'astro',
    'c',
    'css',
    'go',
    'gomod',
    'gosum',
    'gowork',
    'javascript',
    'json',
    'jsx',
    'kotlin',
    'lua',
    'markdown',
    'odin',
    'python',
    'rust',
    'tsx',
    'typescript',
    'vimdoc',
    -- Add here more languages with which you want to use tree-sitter
    -- To see available languages:
    -- - Execute `:=require('nvim-treesitter').get_available()`
    -- - Visit 'SUPPORTED_LANGUAGES.md' file at
    --   https://github.com/nvim-treesitter/nvim-treesitter/blob/main
  }
  local isnt_installed = function(lang) return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0 end
  local to_install = vim.tbl_filter(isnt_installed, languages)
  if #to_install > 0 then require('nvim-treesitter').install(to_install) end

  -- Enable tree-sitter after opening a file for a target language
  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  local ts_start = function(ev) vim.treesitter.start(ev.buf) end
  Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
end)

-- Language servers ===========================================================

-- Language Server Protocol (LSP) is a set of conventions that power creation of
-- language specific tools. It requires two parts:
-- - Server - program that performs language specific computations.
-- - Client - program that asks server for computations and shows results.
--
-- Here Neovim itself is a client (see `:h vim.lsp`). Language servers need to
-- be installed separately based on your OS, CLI tools, and preferences.
-- See note about 'mason.nvim' at the bottom of the file.
--
-- Neovim's team collects commonly used configurations for most language servers
-- inside 'neovim/nvim-lspconfig' plugin.
--
-- Add it now if file (and not 'mini.starter') is shown after startup.

local servers = {
  -- For example, if `lua-language-server` is installed, use `'lua_ls'` entry
  'astro',
  'basedpyright',
  'clangd',
  'cssls',
  'gopls',
  'jsonls',
  'kotlin_lsp',
  'lua_ls',
  'ols',
  'ruff',
  'tailwindcss',
  'vtsls',
}

now_if_args(function()
  add { 'https://github.com/neovim/nvim-lspconfig' }

  -- Use `:h vim.lsp.enable()` to automatically enable language server based on
  -- the rules provided by 'nvim-lspconfig'.
  -- Use `:h vim.lsp.config()` or 'after/lsp/' directory to configure servers.
  -- Uncomment and tweak the following `vim.lsp.enable()` call to enable servers.
  vim.lsp.enable(servers)
end)

-- Formatting =================================================================

-- Programs dedicated to text formatting (a.k.a. formatters) are very useful.
-- Neovim has built-in tools for text formatting (see `:h gq` and `:h 'formatprg'`).
-- They can be used to configure external programs, but it might become tedious.
--
-- The 'stevearc/conform.nvim' plugin is a good and maintained solution for easier
-- formatting setup.
later(function()
  add { 'https://github.com/stevearc/conform.nvim' }

  -- See also:
  -- - `:h Conform`
  -- - `:h conform-options`
  -- - `:h conform-formatters`
  require('conform').setup {
    default_format_opts = {
      -- Allow formatting from LSP server if no dedicated formatter is available
      default_format_opts = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_format = 'fallback',
      },
    },
    -- Map of filetype to formatters
    -- Make sure that necessary CLI tool is available
    formatters_by_ft = {
      astro = { 'prettier' },
      css = { 'prettier' },
      go = { 'gofumpt', 'goimports' },
      javascript = { 'oxfmt' },
      jsx = { 'oxfmt' },
      json = { 'prettier' },
      lua = { 'stylua' },
      python = {
        'ruff_fix',
        'ruff_format',
        'ruff_organize_imports',
      },
      tsx = { 'oxfmt' },
      typescript = { 'oxfmt' },
    },
  }
end)

-- Snippets ===================================================================

-- Although 'mini.snippets' provides functionality to manage snippet files, it
-- deliberately doesn't come with those.
--
-- The 'rafamadriz/friendly-snippets' is currently the largest collection of
-- snippet files. They are organized in 'snippets/' directory (mostly) per language.
-- 'mini.snippets' is designed to work with it as seamlessly as possible.
-- See `:h MiniSnippets.gen_loader.from_lang()`.
later(function() add { 'https://github.com/rafamadriz/friendly-snippets' } end)

-- Honorable mentions =========================================================

-- 'mason-org/mason.nvim' (a.k.a. "Mason") is a great tool (package manager) for
-- installing external language servers, formatters, and linters. It provides
-- a unified interface for installing, updating, and deleting such programs.
--
-- The caveat is that these programs will be set up to be mostly used inside Neovim.
-- If you need them to work elsewhere, consider using other package managers.
--
-- You can use it like so:
now_if_args(function()
  add { 'https://github.com/mason-org/mason.nvim', 'https://github.com/mason-org/mason-lspconfig.nvim' }
  require('mason').setup()
  require('mason-lspconfig').setup {
    automatic_enable = false,
    ensure_installed = servers,
  }
end)

-- Beautiful, usable, well maintained color schemes outside of 'mini.nvim' and
-- have full support of its highlight groups. Use if you don't like 'miniwinter'
-- enabled in 'plugin/30_mini.lua' or other suggested 'mini.hues' based ones.
Config.now(function()
  -- Install only those that you need
  -- add({
  -- 	-- 'https://github.com/sainnhe/everforest',
  -- 	-- 'https://github.com/Shatur/neovim-ayu',
  -- 	-- 'https://github.com/ellisonleao/gruvbox.nvim',
  -- })

  add {
    'https://github.com/rebelot/kanagawa.nvim',
    -- "https://github.com/nyoom-engineering/oxocarbon.nvim",
    -- "https://github.com/vague-theme/vague.nvim",
    -- "https://github.com/metalelf0/kintsugi-nvim",
  }

  require('kanagawa').setup {
    -- colors = {
    -- 	theme = {
    -- 		all = {
    -- 			ui = {
    -- 				bg_gutter = "none",
    -- 			},
    -- 		},
    -- 	},
    -- },
    overrides = function(colors)
      local theme = colors.theme
      local makeDiagnosticColor = function(color)
        local c = require 'kanagawa.lib.color'
        return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
      end

      return {
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
        PmenuKind = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
        PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
        PmenuKindSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },

        DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
        DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
        DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
        DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
      }
    end,
  }

  vim.o.background = 'dark'
  vim.cmd 'color kanagawa'

  -- for vague
  -- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#606079" })

  -- Fixes common issue where Pmenu border is bright white
  vim.api.nvim_set_hl(0, 'PmenuBorder', { link = 'FloatBorder' })

  -- Fixes bright white line in hover popup
  -- vim.api.nvim_set_hl(0, "@spell.markdown", { link = "FloatBorder" })
  -- vim.api.nvim_set_hl(0, "@punctuation.special.markdown", { link = "FloatBorder" })

  -- vim.cmd("colorscheme default")
  -- local set_hl = vim.api.nvim_set_hl
  -- set_hl(0, "MiniTablineCurrent", { fg = "NvimLightGrey2", bg = "NvimDarkGrey3" })
  -- set_hl(0, "MiniTablineModifiedCurrent", { fg = "NvimLightGrey2", bg = "NvimDarkGrey3" })
  -- set_hl(0, "MiniTablineVisible", { fg = "NvimLightGrey3", bg = "NvimDarkGrey2" })
  -- set_hl(0, "MiniTablineHidden", { fg = "NvimLightGrey3", bg = "NvimDarkGrey2" })
  -- set_hl(0, "MiniTablineModifiedVisible", { link = "MiniTablineVisible" })
  -- set_hl(0, "MiniTablineModifiedHidden", { link = "MiniTablineHidden" })
end)

now_if_args(function()
  add {
    {
      src = 'https://github.com/mrcjkb/rustaceanvim',
      version = vim.version.range '^9',
    },
  }
end)

Config.on_event('BufRead~Cargo.toml', function()
  add { 'https://github.com/saecki/crates.nvim' }
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
end)

Config.on_filetype('python', function()
  add { 'https://github.com/linux-cultist/venv-selector.nvim' }
  require('venv-selector').setup {
    options = {
      notify_user_on_venv_activation = true,
      override_notify = false,
    },
  }
end)

now_if_args(function()
  add {
    'https://github.com/j-hui/fidget.nvim',
  }
  require('fidget').setup()
end)

Config.on_filetype('markdown', function() add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' } end)
