function meander_forward --description 'Navigate forward in directory history'
    if test (count $meander_history_forward) -gt 0
        set -U meander_history_back $meander_history_forward[1] $meander_history_back
        set -U meander_history_forward $meander_history_forward[2..-1]

        set -l target_dir $meander_history_back[1]
        if test -d "$target_dir"
            cd "$target_dir"
            commandline -f repaint
        else
            echo "Error: Directory no longer exists: $target_dir"
            set -U meander_history_forward $meander_history_forward[2..-1]
            meander_forward
        end
    else
        echo "No forward history available"
        return 1
    end
end
