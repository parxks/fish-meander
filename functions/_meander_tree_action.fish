function _meander_tree_action
    tree -L 2 --dirsfirst -C 2>/dev/null || exa --tree -L 2 2>/dev/null || ls -la
end
