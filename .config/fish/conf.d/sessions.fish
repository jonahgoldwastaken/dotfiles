if test -z (echo $ZELLIJ)
    function __sessions_attach_or_create -a session
        if test (zellij ls -ns | grep -o $session)
            zellij attach $session
        else
            zellij --session "$session" --layout dev
        end
        clear
    end

    function session
        set -l folder (fd -t d --base-directory $HOME --search-path .config/ --search-path personal/ --search-path work/ -d 3 --absolute-path | fzf)
        if test -z $folder
            return 1
        end

        cd $folder
        __sessions_attach_or_create (path basename $folder)
    end

    bind \cS 'session'
end

