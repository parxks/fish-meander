function meander_fzf_down
    command -q fzf; or begin
        echo "meander: fzf is required for Alt+Shift+Down"
        return 1
    end

    # FZF is an explicit alternate action, so it replaces any active cycle.
    __meander_cycle_end

    set -l raw (__meander_children | string split0)
    set -l children (__meander_sort_children $raw | string split0)

    switch (count $children)
        case 0
            return
        case 1
            cd -- "$children[1]"
            __meander_track (pwd)
            return
    end

    set -l fzf_args --prompt="Meander > " --height=60% --reverse

    if test "$meander_fzf_preview" = true
        if command -q eza
            set fzf_args $fzf_args --preview 'eza --tree --level=2 --color=always {}'
        else
            set fzf_args $fzf_args --preview 'printf "%s\n" {}'
        end
    end

    set -l selected (printf '%s\n' $children | fzf $fzf_args)

    test -n "$selected"; or return

    __meander_set_buffer "$selected"
    __meander_track (realpath -- "$selected")
end
