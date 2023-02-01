set -U fish_greeting
set -Ux LANG en_US.UTF-8
set -Ux LC_ALL $LANG
set -Ux LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"
set -Ux LESS '--mouse --wheel-lines=3'
set -Ux EDITOR nvim
set -Ux VISUAL $EDITOR
set -Ux SUDO_EDITOR $EDITOR
set -Ux PAGER "less -R"
set -Ux BAT_THEME Nord
set -gx PNPM_HOME /Users/jonahmeijers/Library/pnpm
set -Ux GOPATH ~/go
set -Ux N_PRESERVE_COREPACK 1
set -Ux N_PREFIX ~/.n
set -Ux ZELLIJ_AUTO_ATTACH true
set -Ux HOMEBREW_NO_INSTALL_FROM_API 1
set -Ux HOMEBREW_NO_AUTO_UPDATE 1
set -Ux HOMEBREW_NO_ANALYTICS 1
set -Ux fish_user_paths

eval (/usr/local/bin/brew shellenv)
fish_add_path $HOME/.cargo/bin
fish_add_path $GOPATH/bin
fish_add_path $N_PREFIX/bin
fish_add_path $N_PREFIX/lib/node_modules
fish_add_path $PNPM_HOME

if status is-interactive
    eval (zellij setup --generate-auto-start fish | string collect)
    zoxide init fish | source
    update_theme $os_theme
end
