function __meander_escape_cd
    commandline --replace "cd "(string escape -- $argv[1])
    commandline -f repaint
end
