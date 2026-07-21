function meander_fzf_down
    if not command -q fzf
        echo "meander: fzf required"
        return 1
    end

    set -l dirs (__meander_children | string collect)

    if test (count $dirs) -eq 1
        cd $dirs[1]
        return
    end

    set -l selected (printf '%s
' $dirs | fzf --prompt='directory > ')

    test -n "$selected"; and __meander_escape_cd $selected
end
