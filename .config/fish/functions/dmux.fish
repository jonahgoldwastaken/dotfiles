function dmux --description "Start a Zellij session in the current working directory" -a session -a layout
    set -q $layout; or set layout dev
    set -q $session; or set session (path basename (pwd))
    if command zellij list-sessions | grep -q $session
        command zellij attach $session
    else
        command zellij --layout $layout --session "$session"
    end
end
