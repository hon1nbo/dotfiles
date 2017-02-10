#unset GPG_AGENT_INFO
#unset SSH_AUTH_SOCKET
#unset SSH_AGENT_PID

gpg-agent --daemon --enable-ssh-support --sh --use-standard-socket --write-env-file "${HOME}/.gpg-agent-info"
#if [ -f "${HOME}/.gpg-agent-info" ]; then
#   . "${HOME}/.gpg-agent-info"
#  export GPG_AGENT_INFO
#  export SSH_AUTH_SOCK
#  export SSH_AGENT_PID
#fi

GPG_TTY=$(tty)
export GPG_TTY
