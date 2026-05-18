function __meander_complete_commands
    echo -e "meander_status\nmeander_clear"
end

function __meander_complete_directories
    ls -d */ 2>/dev/null | sed 's/\/$//'
end

complete -c meander_status -f -a "(__meander_complete_commands)"
complete -c meander_clear -f -a "(__meander_complete_commands)"
