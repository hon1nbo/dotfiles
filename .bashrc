# Hon1nbo .bash_profile
# handle GnuPG Agent

# Setup GnuPG Agent on login

envfile="$HOME/.gnupg/gpg-agent.env"
if [[ -e "$envfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
	eval "$(cat "$envfile")"
	SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
	GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent"
else
	eval "$(gpg-agent --daemon --enable-ssh-support --pinentry-program /usr/bin/pinentry-curses)"
fi

#export TERM=/usr/bin/uxterm

export GPG_AGENT_INFO # the env file does not contain the export statement
export SSH_AUTH_SOCK # enable gpg-agent as an actual SSH Authentication Agent socket (otherwise ssh-add -L will fail)
export GPG_TTY # This is to allow GPG to know which terminal to run the pin entry on

#if [ -f ~/.bashrc ]; then
#	source ~/.bashrc
#fi

alias fuck='sudo $(history -p \!\!)'
alias fixyourself='sl'

export HISTCONTROL="ignorespace"

alias nohistory='set -o history && $1 set +o history'
