function __meander_cycle_start
    set -l children $argv

    set -g __meander_cycle_active 1
    set -g __meander_cycle_parent (pwd)
    set -g __meander_cycle_children $children
    set -g __meander_cycle_index 0

    set -g __meander_cycle_expires (math "(__meander_now) + $meander_cycle_timeout")
end
