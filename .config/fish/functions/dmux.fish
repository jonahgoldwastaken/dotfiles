function dmux --description "Start a Zellij session in the current working directory" -a session -a layout
    set -q $layout; or set layout dev;
    set -q $session; or set session (path basename (pwd));
    zellij --layout $layout --session "$session"
end
