function __meander_sort_children
    set -l dirs $argv
    set -l result

    if set -q meander_recent_children
        for item in $meander_recent_children
            if contains $item $dirs
                set result $result $item
            end
        end
    end

    for item in $dirs
        if not contains $item $result
            set result $result $item
        end
    end

    printf '%s
' $result
end
