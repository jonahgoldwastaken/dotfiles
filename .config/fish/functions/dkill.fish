function dkill --description "Kill a Zellij session with the name derived from the current directory by default" -a session
    set -q $session; or set session (path basename (pwd))
    if command zellij list-sessions | grep -q $session
        command zellij kill-session $session
    end
end
