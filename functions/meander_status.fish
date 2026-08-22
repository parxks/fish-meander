function meander_status
    echo "meander"
    echo "cycle timeout: $meander_cycle_timeout"
    echo "show hidden:   $meander_show_hidden"
    echo "sort mode:     $meander_sort_mode"
    echo "fzf preview:   $meander_fzf_preview"
    echo "favorites:     "(count $__meander_favorites)
    if set -q __meander_cycle_active
        echo "cycle:         active"
        echo "cycle parent:  $__meander_cycle_parent"
        echo "cycle expires: $__meander_cycle_expires"
    else
        echo "cycle:         inactive"
    end
end
