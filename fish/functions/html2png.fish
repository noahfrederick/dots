function html2png -d 'Create versioned images from HTML files'
	type -fq git; or echo 'git not found in PATH.'; and exit 1
	type -fq webkit2png; or echo 'webkit2png not found in PATH.'; and exit 1

	set -l desktop_width 1440
	set -l mobile_width 375

	for page in $argv
		__html2png_capture $page desktop $desktop_width
		__html2png_capture $page mobile $mobile_width
	end
end

function __html2png_slug
	string replace -r '.*?([^/]+)\.\w+$' '$1' $argv[1]
end

function __html2png_filename
	set -l page (__html2png_slug $argv[1])
	set -l revision (git describe --always)
	set -l format $argv[2]
	echo "$page-$revision-$format"
end

function __html2png_capture
	set -l page $argv[1]
	set -l format $argv[2]
	set -l width $argv[3]
	webkit2png \
		--fullsize \
		--scale=1 \
		--width=$width \
		--filename=screens/(__html2png_filename $page $format) \
		$page
end
