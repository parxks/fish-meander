if not set -q meander_show_hidden
    set -U meander_show_hidden false
end

function __meander_bindings --on-event fish_bindings
    bind alt-up meander_parent
    bind alt-down meander_down
    bind alt-shift-down meander_fzf_down
    bind alt-left prevd
    bind alt-right nextd
end

__meander_bindings
