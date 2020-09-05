function html2png -d 'Create versioned images from HTML files'
	if not type -fq git
		echo 'git not found in PATH.'
		return 1
	end

	set -l desktop_width 1440
	set -l mobile_width 375

	for page in $argv
		__html2png_capture $page desktop $desktop_width
		__html2png_capture $page mobile $mobile_width
	end
end

function __html2png_slug
	string replace --regex '.*?([^/]+)\.\w+$' '$1' $argv[1]
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

	if type -fq cutycapt
		# Make relative path absolute.
		string match --quiet --regex '^[^/]' $page; and set page (pwd)/$page

		cutycapt \
			--out=screens/(__html2png_filename $page $format)-full.png \
			--url=file://$page \
			--delay=300 \
			--min-width=$width
	else if type -fq webkit2png
		webkit2png \
			--fullsize \
			--scale=1 \
			--width=$width \
			--filename=screens/(__html2png_filename $page $format) \
			$page
	else
		echo 'no browser capture utility found in PATH.'
		return 2
	end
end
