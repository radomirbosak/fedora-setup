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
        set -l prepare_list ""
        for file in $godir/*
            set -l row (echo -s (basename $file) ":-> " (readlink $file))
            set prepare_list "$prepare_list\n$row"
        end
        echo -e $prepare_list | column -s ":" -o "  " -t
    case back
        cd -
    case rm
        set -l linkname "$argv[2]"
        rm "$godir/$linkname"
    case clip
        set -l linkname "$argv[2]"
        readlink "$godir/$linkname" | tr -d '\n' | xsel -b
    case print
        set -l linkname "$argv[2]"
        readlink "$godir/$linkname" | tr -d '\n'
    case nav
        set linkname "$argv[2]"
        set linkpath "$godir/$linkname"
        if [ -L "$linkpath" ]
            cd (readlink $linkpath)
            return 0
        else
            echo "Link '$linkname' not found."
            return 1
        end
    case navrev
        for line in (ls $godir)
            set -l link (readlink $godir/$line)
            if [ "$link" = "$PWD" ]
                echo $line
                return 0
            end
        end
        return 1
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
