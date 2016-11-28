function brew --description 'Default arguments for brew'
	set -l OLD_SSL_CERT_FILE $SSL_CERT_FILE
	set -e SSL_CERT_FILE

	if test (count $argv) -gt 0
		command brew $argv
	else
		command brew update
		and echo -s (set_color --bold blue) '==>' \
			(set_color --bold white) ' Outdated Formulae' (set_color normal)
		and command brew outdated
	end

	set -gx SSL_CERT_FILE $OLD_SSL_CERT_FILE
end
