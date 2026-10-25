function __meander_cycle_refresh
    set -l now (__meander_now)
    set -g __meander_cycle_expires (math "$now + $meander_cycle_timeout")
end
