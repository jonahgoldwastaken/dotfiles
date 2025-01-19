function fish_prompt
    set -l last_status $status
    set -l cwd (prompt_pwd)

    if not test $last_status -eq 0
        if test $os_theme = dark
            set_color --bold white -b red
            echo -n ' ! '
            set_color normal
        end
    end

    # Display current path
    if test $os_theme = dark
        set_color black -b blue
    else
        set_color FFFFFF -b blue
    end
    echo -n " $cwd "

    # Show git branch and dirty state
    set -l git_branch (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
    set -l git_dirty (command git status -s --ignore-submodules=dirty 2> /dev/null)
    if test -n "$git_branch"
        if test -n "$git_dirty"
            if test $os_theme = dark
                set_color black -b yellow
            else
                set_color FFFFFF -b yellow
            end
            echo -n " $git_branch "
        else
            if test $os_theme = dark
                set_color black -b green
            else
                set_color FFFFFF -b green
            end
            echo -n " $git_branch "
        end
    end

    # Add a space
    set_color normal
    echo -n ' '
end
