function meander_status --description 'Show meander navigation history details'
    echo "🌊 Meander Navigation Status"
    echo "============================"
    echo "📂 Current: "(pwd)
    echo "⬅️  Back stack: "(count $meander_history_back)" / $meander_max_history"
    echo "➡️  Forward stack: "(count $meander_history_forward)" / $meander_max_history"
    echo "🎮 Smart mode: $meander_smart_mode"
end
