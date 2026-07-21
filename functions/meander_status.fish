function meander_status
    echo "fish-meander"
    echo "Current: "(pwd)
    echo "Recent children:"
    printf '%s
' $meander_recent_children
end
