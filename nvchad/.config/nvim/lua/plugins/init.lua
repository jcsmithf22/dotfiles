return {
  { import = "nvchad.blink.lazyspec" },

  {
    "saghen/blink.cmp",
    opts = {
      signature = {
        enabled = true,
        window = { show_documentation = false },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "folke/which-key.nvim",
    opts = require "configs.whichkey",
    lazy = false,
  },

  {
    "stevearc/oil.nvim",
    opts = {},
    lazy = false,
  },

  { "nvim-mini/mini.misc", version = false, opts = {}, lazy = false },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  --   "mrcjkb/rustaceanvim",
  --   -- To avoid being surprised by breaking changes,
  --   -- I recommend you set a version range
  --   version = "^9",
  --   -- This plugin implements proper lazy-loading (see :h lua-plugin-lazy).
  --   -- No need for lazy.nvim to lazy-load it.
  --   lazy = false,
  -- },

  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    opts = require "configs.rustaceanvim",
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
