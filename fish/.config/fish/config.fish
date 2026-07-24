if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR nvim
set -gx hydro_color_pwd green
set -gx hydro_color_git magenta
set -gx BUN_INSTALL "$HOME/.bun"
set -gx GOPATH "$HOME/go"
set -gx CLOUDFLARE_API_TOKEN dxvY7PxmHuOI4OQItzrJzLIdrUiTXjZoS0jsqfQX
set -gx CLOUDFLARE_DEFAULT_ACCOUNT_ID a0b2310ce2c2d7321e80b5268a9e08b5

set -l operating_system (uname)

if test "$operating_system" = Darwin; and test -x /opt/homebrew/bin/brew
    eval "$(/opt/homebrew/bin/brew shellenv)"
end

if type -q mise
    mise activate fish | source
end

if type -q fnox
    eval "$(fnox activate fish)"
end

fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.local/scripts"
fish_add_path "$HOME/.opencode/bin"
fish_add_path "$HOME/.bun/bin"
fish_add_path "$HOME/go/bin"
fish_add_path "$HOME/personal/c3"

if type -q zoxide
    zoxide init fish | source
    alias cd="z"
end

if type -q eza
    alias ls="eza"
    alias ll="eza -l"
end

alias lg="lazygit"

if type -q fzf
    fzf --fish | source
end

switch $operating_system
    case Darwin
        set -gx ANDROID_HOME "$HOME/Library/Android/sdk"
        set -gx PNPM_HOME "$HOME/Library/pnpm"

        fish_add_path /opt/homebrew/opt/libpq/bin
        fish_add_path "/Applications/Sublime Text.app/Contents/SharedSupport/bin"

        if test -f "$HOME/.orbstack/shell/init2.fish"
            source "$HOME/.orbstack/shell/init2.fish"
        end

    case Linux
        set -gx PNPM_HOME "$HOME/.local/share/pnpm"

        if test -r /proc/version; and string match -qi '*microsoft*' (cat /proc/version)
            alias ssh="ssh.exe"
            alias ssh-add="ssh-add.exe"

            set -gx MISE_CEILING_PATHS /mnt/c/Users/Jsmith
            set -gx UV_PROJECT_ENVIRONMENT ./.venv-ubuntu

            fish_add_path /mnt/c/Windows/System32
            fish_add_path /mnt/c/Windows/System32/WindowsPowerShell/v1.0
            fish_add_path /mnt/c/Windows/System32/OpenSSH
        end
end

# pnpm
if not string match -q -- "$PNPM_HOME/bin" $PATH
    set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end
