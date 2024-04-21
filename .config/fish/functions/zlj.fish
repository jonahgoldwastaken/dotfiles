function zlj
    if test $os_theme = dark
        zellij options --theme gruvbox-dark $argv
    else
        zellij options --theme gruvbox-light $argv
    end
end
