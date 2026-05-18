function meander_smart_down --description 'Context-aware downward directory action'
    set -l current_dir (pwd)
    set -l files (count (ls -A 2>/dev/null))
    set -l git_dir "$current_dir/.git"

    switch $meander_smart_mode
        case git
            _meander_git_action
        case tree
            _meander_tree_action
        case ls
            _meander_ls_action
        case fzf
            _meander_fzf_action
        case project
            _meander_project_action
        case auto
            if test -d "$git_dir"
                _meander_git_action
            else if test $files -eq 0
                _meander_empty_action
            else if command -q tree
                _meander_tree_action
            else
                _meander_ls_action
            end
    end
    commandline -f repaint
end
