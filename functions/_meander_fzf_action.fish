function _meander_fzf_action
    if command -q fzf
        set -l target (ls -d */ 2>/dev/null | fzf --prompt="📁 CD into: " --height=40% --preview='ls -la {}')
        if test -n "$target"
            cd "$target"
        else
            _meander_ls_action
        end
    else
        echo "fzf not installed. Falling back to ls"
        _meander_ls_action
    end
end
