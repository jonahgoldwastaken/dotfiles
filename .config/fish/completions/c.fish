set -l configs "$(ls ~/.config)"

complete -c c -a $configs
