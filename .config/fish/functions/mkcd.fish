function mkcd --description 'Make directory and cd into it immediately'
    mkdir -p $argv && cd $argv
end
