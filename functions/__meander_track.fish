function __meander_track
    set -l target (realpath -- "$argv[1]" 2>/dev/null)
    test -n "$target"; or return

    # Read universal state directly (no global shadowing)
    set -l visit_path $__meander_visit_path
    set -l visit_count $__meander_visit_count

    set -l i 1
    while test $i -le (count $visit_path)
        if test "$visit_path[$i]" = "$target"
            set visit_count[$i] (math "$visit_count[$i] + 1")
            break
        end
        set i (math $i + 1)
    end

    if test $i -gt (count $visit_path)
        set visit_path $target $visit_path
        set visit_count 1 $visit_count
    end

    # Keep universal state bounded. Universal variables persist across shells.
    if test (count $visit_path) -gt 200
        set visit_path $visit_path[1..200]
        set visit_count $visit_count[1..200]
    end

    set -U __meander_visit_path $visit_path
    set -U __meander_visit_count $visit_count

    set -U __meander_recent_dirs $target $__meander_recent_dirs
    set -U __meander_recent_dirs $__meander_recent_dirs[1..100]
end
