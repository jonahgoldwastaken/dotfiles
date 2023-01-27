set -gx LANG en_US.UTF-8
set -gx LESS '--mouse --wheel-lines=3'
set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx PAGER "$(which less) -R"

fish_add_path /usr/local/opt/curl/bin
fish_add_path -p ~/.cargo/bin

set -gx GOPATH ~/go
fish_add_path $GOPATH $GOPATH/bin

set -gx N_PREFIX ~/.n
fish_add_path $N_PREFIX/bin $N_PREFIX/lib/node_modules

# pnpm
set -gx PNPM_HOME /Users/jonahmeijers/Library/pnpm
fish_add_path $PNPM_HOME
# pnpm end

# zellij
set -gx ZELLIJ_AUTO_ATTACH true
# zellij end

if status is-interactive
    if test -d (brew --prefix)"/share/fish/completions"
        set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
    end

    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end

    # Commands to run in interactive sessions can go here
    update_theme $os_theme

    eval (zellij setup --generate-auto-start fish | string collect)
    eval (wezterm shell-completion --shell fish | string collect)
end
