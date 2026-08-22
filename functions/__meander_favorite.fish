function __meander_favorite
    set -l target (realpath -- "$argv[1]" 2>/dev/null)
    test -n "$target"; or return 1

    contains -- "$target" $__meander_favorites
end
