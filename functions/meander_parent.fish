function meander_parent --description 'Navigate up to the parent directory'
    set -l parent_dir (dirname (pwd))
    if test "$parent_dir" != / -o (pwd) != /
        cd ..
        commandline -f repaint
    else
        echo "Already at root directory"
        return 1
    end
end
