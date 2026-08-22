function meander_up
    if __meander_cycle_valid
        set -l children $__meander_cycle_children
        set -l count (count $children)

        set -g __meander_cycle_index (math "$__meander_cycle_index - 1")
        if test $__meander_cycle_index -lt 0
            set -g __meander_cycle_index (math "$count - 1")
        end

        __meander_cycle_refresh
        __meander_set_buffer "$children[(math "$__meander_cycle_index + 1")]"
        return
    end

    cd ..
    commandline -f repaint
end
