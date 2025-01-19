for folder in (path basename $HOME/work/*)
    complete -f -c w -a $folder
end

function w --description "Open a work project" -a folder
    folder $HOME/work $folder
end
