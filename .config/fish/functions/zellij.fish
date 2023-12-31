function zellij
    if test $os_theme = dark
        command zellij options --theme gruvbox-dark $argv
    else
        command zellij options --theme gruvbox-light $argv
    end
end
