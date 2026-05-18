function _meander_track_directory --on-variable PWD --description 'Track directory changes for meander'
    if test "$meander_auto_track" != true
        return
    end

    set -l current_pwd (pwd)
    set -l last_pwd $meander_history_back[1]

    if test "$current_pwd" != "$last_pwd"
        set -U meander_history_back $current_pwd $meander_history_back
        set -U meander_history_forward
        _meander_trim_history
    end
end
