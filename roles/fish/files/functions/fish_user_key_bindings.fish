function fish_user_key_bindings
	bind \cs 'commandline -i "$history[1]"'

	# ctrl+left/right will do large jumps
	# inspired by https://superuser.com/questions/409594/fish-control-left-control-right-keybindings
	bind \e\[1\;5C forward-bigword
	bind \e\[1\;5D backward-bigword
end
