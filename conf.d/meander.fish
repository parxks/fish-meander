# ============================================
# CONFIGURATION DEFAULTS
# ============================================

if not set -q meander_smart_mode
    set -U meander_smart_mode auto
end

if not set -q meander_max_history
    set -U meander_max_history 100
end

if not set -q meander_auto_track
    set -U meander_auto_track true
end

if not set -q meander_history_back
    set -U meander_history_back (pwd)
end

if not set -q meander_history_forward
    set -U meander_history_forward
end

# ============================================
# CD WRAPPER (History Tracking)
# ============================================

function cd --wraps=cd --description 'Change directory with meander tracking'
    if test "$meander_auto_track" = true
        set -l old_pwd (pwd)
        builtin cd $argv
        if test "$old_pwd" != (pwd)
            _meander_track_directory
        end
    else
        builtin cd $argv
    end
end

# ============================================
# KEY BINDINGS (Safe & Isolated)
# ============================================

function __meander_init_bindings --on-event fish_bindings
    # Clear out any old bindings cleanly
    bind -e -a alt-up
    bind -e -a alt-down
    bind -e -a alt-left
    bind -e -a alt-right
    bind -e -a \e\[1\;3A

    # Core Meander bindings (Fish syntax uses hyphen)
    bind alt-left meander_back
    bind alt-right meander_forward
    bind alt-up meander_parent
    bind alt-down meander_smart_down

    # Shift combinations (Fish syntax handles modifiers sequentially)
    bind alt-shift-left meander_back
    bind alt-shift-right meander_forward
    bind alt-shift-up meander_parent
    bind alt-shift-down meander_smart_down
end

__meander_init_bindings

if not set -q meander_loaded
    echo "🌊 meander.fish loaded: Navigate with Alt+← → ↑ ↓" >/dev/tty
    set -U meander_loaded true
end
