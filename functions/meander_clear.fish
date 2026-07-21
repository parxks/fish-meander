function meander_clear
    set -U meander_recent_children
    __meander_reset_cycle
    echo "meander cleared"
end
