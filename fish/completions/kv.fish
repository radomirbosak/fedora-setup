set kvdir $HOME/.keyvalue

complete -c kv -n 'not _kv_is_file' -fa list  --description "List available data files"
complete -c kv -n 'not _kv_is_file' -xa keys  --description "List available keys in a data file"
complete -c kv -n 'not _kv_is_file' -xa value --description "Display value corresponding to the key in a data file"
complete -c kv -n 'not _kv_is_file' -xa grep  --description "Like value, but matches also inside of the keystring (no regex, sorry)"
complete -c kv -n 'not _kv_is_file' -xa edit  --description "Edits the specified data file"
complete -c kv -n 'not _kv_is_file' -xa rm    --description "Removes the specified data file"

# data files
complete -c kv -n 'not _kv_is_file' -fa "(ls $kvdir)"

# autocomplete keys
complete -c kv -n '_kv_is_file' -xa "(_kv_list_keys $kvdir/(_kv_last_arg))"

function _kv_last_arg
    set lastarg (commandline -poc)
    echo "$lastarg[-1]"
end

function _kv_is_file
    set -l fullpath $kvdir/(_kv_last_arg)
    [ -f $fullpath ]
end
