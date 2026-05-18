function meander_back --description 'Navigate back in directory history'
    if test (count $meander_history_back) -gt 1
        set -U meander_history_forward $meander_history_back[1] $meander_history_forward
        set -U meander_history_back $meander_history_back[2..-1]

        set -l target_dir $meander_history_back[1]
        if test -d "$target_dir"
            cd "$target_dir"
            commandline -f repaint
        else
            echo "Error: Directory no longer exists: $target_dir"
            set -U meander_history_back $meander_history_back[2..-1]
            meander_back
        end
    else
        echo "No back history available"
        return 1
    end
end
