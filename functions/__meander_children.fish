function __meander_children
    set -l dirs */

    if test "$meander_show_hidden" = true
        set dirs .*/ */
    end

    for dir in $dirs
        test -d "$dir"; and string trim -r -c / -- "$dir"
    end
end
