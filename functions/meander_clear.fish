function meander_clear --description 'Reset meander history stacks'
    set -U meander_history_back (pwd)
    set -U meander_history_forward
    echo "✓ Meander history cleared"
end
