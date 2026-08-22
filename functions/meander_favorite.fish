function meander_favorite
    set -l action $argv[1]

    if not set -q __meander_favorites
        set -U __meander_favorites
    end

    switch "$action"
        case add
            set -l target $argv[2]
            test -n "$target"; or set target (pwd)
            set target (realpath -- "$target" 2>/dev/null)
            test -d "$target"; or begin
                echo "meander: not a directory: $target" >&2
                return 1
            end
            contains -- "$target" $__meander_favorites; and return 0
            set -U __meander_favorites $__meander_favorites $target
            echo "Added favorite: $target"

        case remove
            set -l target $argv[2]
            test -n "$target"; or set target (pwd)
            set target (realpath -- "$target" 2>/dev/null)
            set -l result
            for favorite in $__meander_favorites
                test "$favorite" = "$target"; or set result $result $favorite
            end
            set -U __meander_favorites $result

        case list
            printf '%s\n' $__meander_favorites

        case jump
            command -q fzf; or begin
                echo "meander: fzf is required for favorite jump"
                return 1
            end
            set -l selected (printf '%s\n' $__meander_favorites | fzf --prompt="Favorite > " --reverse)
            test -n "$selected"; or return
            cd -- "$selected"
            __meander_track (pwd)

        case '*'
            echo "Usage: meander favorite {add|remove|list|jump} [PATH]" >&2
            return 2
    end
end
