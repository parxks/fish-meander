function __meander_cycle_valid
    set -q __meander_cycle_active; or return 1

    set -l now (__meander_now)
    if test $now -ge $__meander_cycle_expires
        __meander_cycle_end
        return 1
    end

    set -l buffer (commandline)

    # Empty buffer explicitly ends the sibling context.
    if test -z "$buffer"
        __meander_cycle_end
        return 1
    end

    # The session belongs to the exact parent directory from which it began.
    test (pwd) = "$__meander_cycle_parent"; or begin
        __meander_cycle_end
        return 1
    end

    return 0
end
