function __meander_project_marker
    set -l dir $argv[1]

    for marker in .git Cargo.toml package.json go.mod pyproject.toml CMakeLists.txt Makefile
        test -e "$dir/$marker"; and return 0
    end

    return 1
end
