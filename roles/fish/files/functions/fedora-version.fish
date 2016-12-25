function fedora-version
	grep -o '[[:digit:]]\{2\}' /etc/fedora-release;
end
