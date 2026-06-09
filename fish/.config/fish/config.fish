if status is-interactive
    # Commands to run in interactive sessions can go here
end

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fnox activate fish)"

zoxide init fish | source
alias cd="z"
alias ls="eza"
alias ll="eza -l"
alias lg="lazygit"

set -x hydro_color_pwd green
set -x hydro_color_git magenta

set -x CLOUDFLARE_API_TOKEN dxvY7PxmHuOI4OQItzrJzLIdrUiTXjZoS0jsqfQX
set -x CLOUDFLARE_DEFAULT_ACCOUNT_ID a0b2310ce2c2d7321e80b5268a9e08b5

set ANDROID_HOME '~/Library/Android/sdk'

# Set up fzf key bindings
fzf --fish | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# pnpm
set -gx PNPM_HOME "/Users/jsmith/Library/pnpm"
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end
