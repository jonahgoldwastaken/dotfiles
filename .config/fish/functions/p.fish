for project in (path basename ~/programmeren/*)
    complete -f -c p -a $project
end

function p --description "Open a programming project" -a project
    set -l P_FOLDER /Users/jonahmeijers/programmeren
    test -n "$project"; or set -l project (path basename -Z $P_FOLDER/* | fzf --read0 --print0)
    cd "$P_FOLDER/$project"
end
