for project in (path basename ~/programmeren/*)
    complete -f -c p -a $project
end

function p
    set -l P_FOLDER /Users/jonahmeijers/programmeren
    cd "$P_FOLDER/$argv[1]"
end
