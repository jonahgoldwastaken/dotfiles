for folder in (path basename $HOME/.config/*)
    complete -f -c c -a $folder
end

function c --description "Open a config folder" -a config
    folder $HOME/.config $config
end
