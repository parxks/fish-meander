function __meander_sort_children
    set -l children $argv
    test (count $children) -gt 1; or begin
        test (count $children) -gt 0; and printf '%s\n' $children
        return
    end

    if test "$meander_sort_mode" = alphabetical
        printf '%s\n' $children | sort
        return
    end

    set -l scored

    for child in $children
        set -l score 0
        set -l absolute (realpath -- "$child" 2>/dev/null)

        # Last selected child for this parent gets the strongest preference.
        if set -q __meander_last_child
            test "$__meander_last_child" = "$absolute"; and set score (math $score + 10000)
        end

        # Favorites receive a substantial but not absolute preference.
        if __meander_favorite "$absolute"
            set score (math $score + 5000)
        end

        # Visit frequency.
        if set -q __meander_visit_path
            set -l i 1
            while test $i -le (count $__meander_visit_path)
                if test "$__meander_visit_path[$i]" = "$absolute"
                    set -l visit_count_i $__meander_visit_count[$i]
                    set score (math "$score + $visit_count_i * 10")
                    break
                end
                set i (math "$i + 1")
            end
        end

        # Recent visits: earlier entries in the bounded MRU list score higher.
        if set -q __meander_recent_dirs
            set -l i 1
            while test $i -le (count $__meander_recent_dirs)
                if test "$__meander_recent_dirs[$i]" = "$absolute"
                    set -l recent_count (count $__meander_recent_dirs)
                    set score (math "$score + $recent_count - $i")
                    break
                end
                set i (math "$i + 1")
            end
        end

        # Small project bonus.
        if __meander_project_marker "$child"
            set score (math $score + 100)
        end

        # NUL-safe sortable record: score + path. Numeric score is fixed width.
        printf '%010d\t%s\0' $score "$child"
    end | sort -z -r | string split0 | string replace -r '^[0-9]+\t' ''
end
