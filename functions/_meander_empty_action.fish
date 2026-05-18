function _meander_empty_action
    echo "📁 Empty directory. Create common structure? (y/n)"
    read -l response
    if test "$response" = y -o "$response" = yes
        mkdir -p src docs tests scripts config
        touch README.md LICENSE .gitignore .env.example
        echo "✓ Created layout and boilerplate."
        _meander_ls_action
    end
end
