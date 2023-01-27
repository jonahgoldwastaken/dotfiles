set -l projects "$(ls ~/programmeren)"

complete -c p -a $projects
