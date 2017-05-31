function viewmd
	set -l htmlout (mktemp --suff .html)
pandoc $argv[1] -o $htmlout
xdg-open $htmlout
end
