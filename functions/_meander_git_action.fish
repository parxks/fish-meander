function _meander_git_action
    set -l git_status (git status -sb 2>/dev/null)
    if test $status -eq 0
        echo "📊 Git Status:"
        echo "$git_status" | head -20
        set -l commit_count (git rev-list --count HEAD 2>/dev/null)
        echo "📝 Total commits: $commit_count"
        if test (git status -s | wc -l) -gt 0
            echo "⚠️  Uncommitted changes detected"
        end
    else
        _meander_ls_action
    end
end
