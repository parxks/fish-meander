function __meander_set_buffer
    set -l path $argv[1]
    commandline --replace "cd "(string escape -- "$path")
    commandline -f repaint
end
