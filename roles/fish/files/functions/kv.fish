function kv
    set -l kvdir "$HOME/.keyvalue"
    set -l editor subl

    if [ ! -d $kvdir ]
        echo "Creating the directory '$kvdir'."
        mkdir $kvdir
    end

    set -l argc (count $argv)
    if [ $argc -eq 0 ]
        _kv_usage
        return 0
    end

    set -l action "$argv[1]"

    switch $action
    case list l
        ls $kvdir
    case keys
        _kv_list_keys "$kvdir/$argv[2]"
    case edit e
        set -l target_file "$kvdir/$argv[2]"
        eval $editor $target_file
    case rm
        set -l target_file "$kvdir/$argv[2]"
        if [ -f $target_file ]
            rm $target_file
        else
            echo "file $target_file not found"
        end
    case value
        if [ $argc -lt 3 ]
            echo "Missing parameters"
            _kv_usage
            return 1
        end
        set -l target_file "$kvdir/$argv[2]"
        if [ -f $target_file ]
            set -l key "$argv[3]"
            grep "^$key: " $target_file | sed 's/^.*:[ \t]*//'
        else
            echo "file $target_file not found"
        end
    case grep
        if [ $argc -lt 3 ]
            echo "Missing parameters"
            _kv_usage
            return 1
        end
        set -l target_file "$kvdir/$argv[2]"
        if [ -f $target_file ]
            set -l key "$argv[3]"
            grep "$key.*:.*" $target_file | sed 's/^.*:[ \t]*//'
        else
            echo "file $target_file not found"
        end
    case '*'
        set -l target_file $kvdir/$action
        if [ -f $target_file ]
            if [ $argc -ge 2 ]
                # print keyvalue
                set -l key "$argv[2]"
                grep "^$key:.*" $target_file | sed 's/^.*:[ \t]*//'
            else
                #print entire file
                cat $target_file
            end
        else
            echo "file $target_file not found"
        end
    end
end

function _kv_usage
    echo -e "Usage:\n"
    echo "kv list"
    echo "kv keys <filename>"
    echo "kv edit <filename>"
    echo "kv rm <filename>"
    echo "kv value <filename>"
    echo "kv grep <filename>"
    echo "kv <filename>"
end

function _kv_list_keys
    # arg1: abspath to file from which to extract keys
    set -l argc (count $argv)

    if [ $argc -lt 1 ]
        echo "Missing parameter <datafile>"
        _kv_usage
        return 1
    end

    set -l target_file "$argv[1]"

    if [ ! -f $target_file ]
        return 1
    end
    grep -E "^(.*?):" $target_file -o | tr -d ':'
end