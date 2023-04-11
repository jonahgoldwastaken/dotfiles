function folder -a base -a folder
    test -n "$folder"; or set -l folder (path basename -Z $base/* | fzf --read0 --print0)
    cd $base/$folder
end
