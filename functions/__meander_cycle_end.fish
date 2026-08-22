function __meander_cycle_end
    set -e __meander_cycle_active
    set -e __meander_cycle_parent
    set -e __meander_cycle_children
    set -e __meander_cycle_index
    set -e __meander_cycle_expires
end
