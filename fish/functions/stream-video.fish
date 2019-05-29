function stream-video -w youtube-dl -d "Find video URL and open with VLC"
	vlc (youtube-dl --get-url --format best $argv)
end

