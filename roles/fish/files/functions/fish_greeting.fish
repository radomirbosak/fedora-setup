function fish_greeting
    set -l m1 (math (random)'%20')
    set -l m2 (math (random)'%20')

    echo -n "         "

    for i in (seq $m1)
        echo -n " "
    end
    echo -n "🐟"

    for i in (seq $m2)
        echo -n " "
    end
    echo -n "🐟"

    echo -n " "
end