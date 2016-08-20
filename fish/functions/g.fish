function g
    set -l godir "$HOME/.g"

    if [ ! -d $godir ]
        echo "Creating the directory '$godir'."
        mkdir $godir
    end

    if [ (count $argv) -eq 0 ]
        echo "Usage:"
        echo "g create mydir  # creates a link to this directory under the name 'mydir'"
        echo "g mydir  # navigates to 'mydir'"
        return 0
    end

    set -l action "$argv[1]"

    switch $action
    case create
        set -l linkname "$argv[2]"
        # echo "C create $argv[2]"
        ln -snv (pwd) "$godir/$linkname"
    case list
        for file in $godir/*
            echo -s (basename $file) " -> " (readlink $file)
        end
    case back
        cd -
    case rm
        set -l linkname "$argv[2]"
        rm "$godir/$linkname"
    case clip
        set -l linkname "$argv[2]"
        readlink "$godir/$linkname" | tr -d '\n' | xsel -b
    case '*'
        set linkname "$action"
        set linkpath "$godir/$linkname"
        if [ -L "$linkpath" ]
            cd (readlink $linkpath)
            return 0
        else
            echo "Link '$linkname' not found."
            return 1
        end
    end

end
