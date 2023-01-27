for cfg in (path basename ~/.config/*)
    complete -f -c c -a $cfg
end

function c --argument-name config
    set -l C_FOLDER "/Users/jonahmeijers/.config"
    if not test -d "$C_FOLDER/$config"
        set_color red
        echo "Folder does not exist"
        set_color normal
        return
    end
    cd "$C_FOLDER/$config"
    nvim
end
