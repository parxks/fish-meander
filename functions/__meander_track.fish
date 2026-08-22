function __meander_track
    set -l target (realpath -- "$argv[1]" 2>/dev/null)
    test -n "$target"; or return

    if not set -q __meander_visit_path
        set -g __meander_visit_path
        set -g __meander_visit_count
    end

    set -l i 1
    while test $i -le (count $__meander_visit_path)
        if test "$__meander_visit_path[$i]" = "$target"
            set -g __meander_visit_count[$i] (math "$__meander_visit_count[$i] + 1")
            break
        end
        set i (math $i + 1)
    end

    if test $i -gt (count $__meander_visit_path)
        set -g __meander_visit_path $target $__meander_visit_path
        set -g __meander_visit_count 1 $__meander_visit_count
    end

    # Keep universal state bounded. Universal variables persist across shells.
    if test (count $__meander_visit_path) -gt 200
        set -g __meander_visit_path $__meander_visit_path[1..200]
        set -g __meander_visit_count $__meander_visit_count[1..200]
    end

    set -U __meander_visit_path $__meander_visit_path
    set -U __meander_visit_count $__meander_visit_count

    set -U __meander_recent_dirs $target $__meander_recent_dirs
    set -U __meander_recent_dirs $__meander_recent_dirs[1..100]
end
