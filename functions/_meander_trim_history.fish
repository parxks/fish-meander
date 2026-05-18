function _meander_trim_history --description 'Trim meander history stacks to max size'
    while test (count $meander_history_back) -gt $meander_max_history
        set -U meander_history_back $meander_history_back[1..-2]
    end
    while test (count $meander_history_forward) -gt $meander_max_history
        set -U meander_history_forward $meander_history_forward[1..-2]
    end
end
