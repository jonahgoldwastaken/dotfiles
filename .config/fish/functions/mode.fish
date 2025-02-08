function mode --description "Set mode" -a mode
    if test $mode = "light"
        set -Ux os_theme light
        sed -i '' 's/^\(theme = "Gruvbox\).*"$/\1Light"/' "$HOME/.config/ghostty/config"
        sed -i '' 's/^\(theme "gruvbox-\).*"$/\1light"/' "$HOME/.config/zellij/config.kdl"
        sed -i '' 's/^\(\s\+pager: delta\).*$/\1--paging=never"/' "$HOME/.config/zellij/config.kdl"
    else if test $mode = "dark"
        set -Ux os_theme dark
        sed -i '' 's/^\(theme = "Gruvbox\).*"$/\1Dark"/' "$HOME/.config/ghostty/config"
        sed -i '' 's/^\(theme "gruvbox-\).*"$/\1dark"/' "$HOME/.config/zellij/config.kdl"
        sed -i '' 's/^\(\s\+pager: delta\).*$/\1 --dark --paging=never"/' "$HOME/.config/lazygit/config.yml"
    else
        return 1
    end
end
