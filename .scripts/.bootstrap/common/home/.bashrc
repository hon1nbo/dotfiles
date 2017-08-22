# Hon1nbo .bash_profile

# Setup GnuPG Agent on login

envfile="$HOME/.gnupg/gpg-agent.env"
if [[ -e "$envfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
	eval "$(cat "$envfile")"
	SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
	GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent"
else
	eval "$(gpg-agent --daemon --enable-ssh-support --pinentry-program 
/usr/bin/pinentry-curses)"
fi

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi

export GPG_AGENT_INFO # the env file does not contain the export statement
## this may be no longer required
#export SSH_AUTH_SOCK # enable gpg-agent as an actual SSH Authentication Agent socket (otherwise 
ssh-add -L will fail)
export GPG_TTY # This is to allow GPG to know which terminal to run the pin entry on
echo UPDATESTARTUPTTY | gpg-connect-agent


alias fuck='sudo $(history -p \!\!)'

export HISTCONTROL="ignorespace"

alias nohistory='set -o history && $1 set +o history'

###################################################
### Below this line is added by the bootstrapper ##
###################################################
