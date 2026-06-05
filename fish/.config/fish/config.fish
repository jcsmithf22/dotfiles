if status is-interactive
# Commands to run in interactive sessions can go here
end

alias ssh="ssh.exe"
alias ssh-add="ssh-add.exe"
alias cd="z"
alias lg="lazygit"

set -x hydro_color_pwd green
set -x hydro_color_git magenta
set -x MISE_CEILING_PATHS /mnt/c/Users/Jsmith
set -x UV_PROJECT_ENVIRONMENT ./.venv-ubuntu
set -x EDITOR nvim

mise activate fish | source
zoxide init fish | source

fzf --fish | source

# opencode
fish_add_path /home/jsmith/.opencode/bin

# Amp CLI
fish_add_path "$HOME/.local/bin"

# Windows interop tools for WSL clipboard integration
fish_add_path /mnt/c/Windows/System32
fish_add_path /mnt/c/Windows/System32/WindowsPowerShell/v1.0

# pnpm
set -gx PNPM_HOME "/home/jsmith/.local/share/pnpm"
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end
