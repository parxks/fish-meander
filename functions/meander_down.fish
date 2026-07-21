function meander_down
    set -l dirs (__meander_children | string collect)
    set dirs (__meander_sort_children $dirs)

    switch (count $dirs)
        case 0
            return
        case 1
            cd $dirs[1]
            set -U meander_recent_children $dirs[1] $meander_recent_children
            return
    end

    if test "$PWD" != "$__meander_cycle_parent"
        set -g __meander_cycle_parent $PWD
        set -g __meander_cycle_index 0
    end

    set -g __meander_cycle_index (math "($__meander_cycle_index % "(count $dirs)") + 1")
    set -l selected $dirs[$__meander_cycle_index]

    __meander_escape_cd $selected

    set -U meander_recent_children $selected $meander_recent_children
end
