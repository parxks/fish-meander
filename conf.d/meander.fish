# fish-meander
# Configuration and key bindings.

if not set -q meander_cycle_timeout
    set -U meander_cycle_timeout 15
end

if not set -q meander_show_hidden
    set -U meander_show_hidden false
end

if not set -q meander_fzf_preview
    set -U meander_fzf_preview true
end

if not set -q meander_sort_mode
    set -U meander_sort_mode intelligent
end

# Fish calls this event when the commandline is accepted.
function __meander_accept --on-event fish_preexec
    meander_clear
end

# Reset Meander state whenever the user returns to a prompt after execution.
function __meander_postexec_reset --on-event fish_postexec
    meander_clear
end

function __meander_install_bindings --on-event fish_bindings
    bind alt-up meander_up
    bind alt-down meander_down
    bind alt-shift-down meander_fzf_down
    bind alt-left prevd
    bind alt-right nextd
end

__meander_install_bindings
