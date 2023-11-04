function isgr --description "Check if folder is a git repository" -a folder
    test -n "$folder"; or set -l folder (pwd)

    return (test -n (git -C $folder rev-parse --is-inside-work-tree 2>/dev/null))
end
