function _meander_project_action
    set -l markers .git package.json Cargo.toml go.mod setup.py composer.json
    set -l found_projects

    for marker in $markers
        set -l matches (find . -maxdepth 3 -name "$marker" -type f 2>/dev/null | head -5)
        for match in $matches
            set -l proj_dir (dirname $match)
            if not contains $proj_dir $found_projects
                set found_projects $found_projects $proj_dir
            end
        end
    end

    if test (count $found_projects) -gt 0
        echo "🎯 Found projects:"
        for i in (seq 1 (count $found_projects))
            echo "  $i. $found_projects[$i]"
        end
        echo "Enter number or directory name:"
        read -l choice
        if test -d "$choice"
            cd "$choice"
        else if string match -r '^\d+$' $choice
            if test $choice -le (count $found_projects)
                cd $found_projects[$choice]
            end
        end
    else
        _meander_ls_action
    end
end
