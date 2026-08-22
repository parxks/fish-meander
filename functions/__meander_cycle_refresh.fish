function __meander_cycle_refresh
    set -g __meander_cycle_expires (math "(__meander_now) + $meander_cycle_timeout")
end
