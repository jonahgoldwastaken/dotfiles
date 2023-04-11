set -U fish_greeting
set -gx LANG en_US.UTF-8
set -gx LC_ALL $LANG
set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx PAGER "less -R"
set -gx BAT_THEME Nord
set -gx FZF_DEFAULT_OPTS --bind=ctrl-l:clear-query
set -gx LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"
set -gx PNPM_HOME $HOME/Library/pnpm
set -gx N_PRESERVE_COREPACK 1
set -gx N_PREFIX ~/.n
set -gx HOMEBREW_NO_INSTALL_FROM_API 1
set -gx HOMEBREW_NO_ANALYTICS 1

if test -d /opt/homebrew
    eval (/opt/homebrew/bin/brew shellenv | string collect)
else
    eval (/usr/local/bin/brew shellenv | string collect)
end

fish_add_path -p $HOME/.cargo/bin
fish_add_path $N_PREFIX/bin
fish_add_path $N_PREFIX/lib/node_modules
fish_add_path $PNPM_HOME

if status is-interactive
    zoxide init fish | source
    update_theme
end
