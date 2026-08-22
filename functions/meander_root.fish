function meander_root
    set -l dir (pwd)

    while true
        for marker in .git Cargo.toml package.json go.mod pyproject.toml CMakeLists.txt Makefile
            if test -e "$dir/$marker"
                cd -- "$dir"
                commandline -f repaint
                __meander_track "$dir"
                return 0
            end
        end

        set -l parent (string split -r -m1 / -- "$dir")[1]
        test -z "$parent"; and set parent /
        test "$parent" = "$dir"; and return 1
        set dir "$parent"
    end
end
