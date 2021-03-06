set godir $HOME/.g

function __fish_command_begins
    set cmd (commandline -opc)
    if [ (count $cmd) -eq 1 ]
        return 0
    else
        return 1
    end
end

function __fish_g_list_links
    if test -d $godir
        ls $godir
    end
end

complete -f -c g -n '__fish_command_begins' -a list    -d 'Lists links'
complete -f -c g -n '__fish_command_begins' -a create  -d 'Create a new link'
complete -f -c g -n '__fish_command_begins' -a back    -d 'Go back'
complete -f -c g -n '__fish_command_begins' -a rm      -d 'Remove a link'
complete -f -c g -n '__fish_command_begins' -a clip    -d 'Copy the link destination to clipboard'
complete -f -c g -a '(__fish_g_list_links)'
complete -f -c g -n '__fish_command_begins' -a nav     -d 'Navigate to link'
complete -f -c g -n '__fish_command_begins' -a print   -d 'Print the link'

complete -f -c g -n '__fish_use_subcommand nav'   -a '(__fish_g_list_links)'
complete -f -c g -n '__fish_use_subcommand print' -a '(__fish_g_list_links)'
complete -f -c g -n '__fish_use_subcommand clip'  -a '(__fish_g_list_links)'
complete -f -c g -n '__fish_use_subcommand rm'    -a '(__fish_g_list_links)'