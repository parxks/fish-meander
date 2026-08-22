function __meander_children
    set -l dirs

    if test "$meander_show_hidden" = true
        set dirs .*/ */
    else
        set dirs */
    end

    for dir in $dirs
        test -d "$dir"; or continue
        set -l clean (string trim -r -c / -- "$dir")
        test -n "$clean"; and printf '%s\0' "$clean"
    end
end
