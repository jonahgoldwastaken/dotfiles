function folder -a base -a folder
    test -n "$folder"; or set -l folder (path basename -Z $base/* | fzf --read0 --print0)
    if isgr $base/$folder
        cd $base/$folder
    else
        folder $base/folder
    end
end
