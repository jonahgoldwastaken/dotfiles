# Git/GitHub
function __gp_set_upstream
    echo "git push -u origin (git branch --show-current)"
end

abbr --add ghcr gh repo create -s . -r origin --private --push
abbr --add gl git pull
abbr --add gp git push
abbr --add gpu --function __gp_set_upstream
abbr --add gs git status
abbr --add gco git checkout
abbr --add gcb git checkout -b
abbr --add gcm git commit -m
