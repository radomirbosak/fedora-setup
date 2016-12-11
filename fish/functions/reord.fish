function reord
    # print usage if there are not enough arguments
    if [ (count $argv) -le 1 ]
        echo "Usage: reord PERMUTATION ARGS.."
        return 1
    end

    # read permuatations
    set -l numbers (string split '' $argv[1])
    set -e argv[1]

    # exit if permutations refer to non-existent arguments
    if [ (_math_max $numbers) -gt (count $argv) ]
        echo "Too few arguments"
        return 1
    end

    # build new argument array
    set -l counter 1
    set -l newargv
    for position in $numbers
        set newargv[$position] $argv[$counter]
        set counter (math $counter + 1)
    end

    # execute the reordered command
    eval $newargv
end

function _math_max
    # return maximal number from array
    set -l maxnum $argv[1]
    for num in $argv
        if [ $num -gt $maxnum ]
            set maxnum $num
        end
    end
    echo $maxnum
end