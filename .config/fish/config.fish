set -U fish_greeting
set -Ux LANG en_US.UTF-8
set -Ux LC_ALL $LANG
set -Ux EDITOR nvim
set -Ux VISUAL $EDITOR
set -Ux SUDO_EDITOR $EDITOR
set -Ux PAGER "less -R"
set -Ux LESS '--wheel-lines=3'
set -Ux BAT_THEME Nord
set -Ux FZF_DEFAULT_OPTS --bind=ctrl-l:clear-query
set -Ux LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"
set -Ux PNPM_HOME /Users/jonahmeijers/Library/pnpm
set -Ux GOPATH ~/programmeren/go
set -Ux N_PRESERVE_COREPACK 1
set -Ux N_PREFIX ~/.n
set -Ux ZELLIJ_AUTO_ATTACH true
set -Ux HOMEBREW_NO_INSTALL_FROM_API 1
set -Ux HOMEBREW_NO_ANALYTICS 1

eval (/usr/local/bin/brew shellenv | string collect)
set -e PATH[2]
set -e PATH[1]
# set -q PATH; and set PATH /opt/homebrew/opt/coreutils/libexec/gnubin $PATH

fish_add_path -p $HOME/.cargo/bin
fish_add_path $GOPATH/bin
fish_add_path $N_PREFIX/bin
fish_add_path $N_PREFIX/lib/node_modules
fish_add_path $PNPM_HOME

if status is-interactive
    eval (zellij setup --generate-auto-start fish | string collect)
    zoxide init fish | source
    update_theme
end
