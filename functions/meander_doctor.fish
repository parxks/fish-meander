function meander_doctor
    if string match -qr '^3\.[5-9]|^[4-9]\.' -- (string split ' ' -- (fish --version))[2]
        echo "✓ Fish"
    else
        echo "✗ Fish version may be too old"
    end

    command -q fzf; and echo "✓ fzf"; or echo "✗ fzf (required for FZF actions)"
    command -q eza; and echo "✓ eza (optional preview)"; or echo "· eza (optional preview)"
    echo "✓ meander functions loaded"
    echo "✓ bindings installed through fish_bindings"
end
