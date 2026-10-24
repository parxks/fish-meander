function meander_down
    # Any explicit Down starts or continues Meander child navigation.
    if __meander_cycle_valid
        set -l children $__meander_cycle_children
        set -g __meander_cycle_index (math "($__meander_cycle_index + 1) % "(count $children))
        __meander_cycle_refresh
        __meander_set_buffer "$children[(math "$__meander_cycle_index + 1")]"
        return
    end

    set -l raw (__meander_children | string split0)
    set -l children (__meander_sort_children $raw)

    switch (count $children)
        case 0
            return
        case 1
            # Single-child navigation is deliberately unconditional.
            cd -- "$children[1]"
            __meander_track (pwd)
            return
    end

    __meander_cycle_start $children
    set -g __meander_cycle_index 0
    __meander_cycle_refresh
    __meander_set_buffer "$children[1]"
    __meander_track (realpath -- "$children[1]")
end
