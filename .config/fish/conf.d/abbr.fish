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
abbr --add gst git status
abbr --add gbd git branch -D
abbr --add gmd git merge develop --no-edit
abbr --add gmod git merge origin/develop --no-edit
abbr --add grod git rebase origin/develop
abbr --add gcp git cherry-pick -m1
abbr --add gcbc git checkout -b cherry-pick-
abbr --add gcbr git checkout -b revert-
abbr --add gcno git commit --no-edit
abbr --add gfa git fetch --all
abbr --add gfap git fetch --all --prune
