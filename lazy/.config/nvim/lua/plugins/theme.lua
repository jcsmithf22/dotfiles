return {
  {
    "rebelot/kanagawa.nvim",
    opts = {
      overrides = function(colors)
        local theme = colors.theme
        local makeDiagnosticColor = function(color)
          local c = require("kanagawa.lib.color")
          return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
        end

        return {
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuKind = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuKindSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          NoiceCmdlinePopupBorder = { bg = theme.ui.bg, fg = theme.ui.fg },
          NoiceCmdlineIcon = { bg = theme.ui.bg, fg = theme.ui.fg_dim },
          SnacksIndent = { fg = theme.ui.bg_p1 },
          SnacksPickerCol = { bg = theme.ui.bg_m3 },
          SnacksPickerTree = { bg = theme.ui.bg_m3 },
          SnacksPickerPrompt = { bg = theme.ui.bg_dim },
          StatusLine = { bg = theme.ui.bg_p1 },

          DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
          DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
          DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
          DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
        }
      end,
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}
