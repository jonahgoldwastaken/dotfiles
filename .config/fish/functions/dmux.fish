function dmux --description "Start a Zellij session in the current working directory" -a session -a layout
    set -q $layout; or set layout dev
    set -q $session; or set session (path basename (pwd))
    if zellij list-sessions | grep -q $session
        zellij attach $session
    else
        zellij --layout $layout --session "$session"
    end
end
