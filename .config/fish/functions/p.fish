for folder in (path basename $HOME/personal/*)
    complete -f -c p -a $folder
end

function p --description "Open a personal project" -a folder
    folder $HOME/personal $folder
end
