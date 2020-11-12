# bash_alises

alias fuck='sudo $(history -p \!\!)'

export HISTCONTROL="ignorespace"

alias nohistory='set -o history && $1 set +o history'

if [ -f /usr/bin/i3lock.sh ]; then
    alias lock='/usr/bin/i3lock.sh'
fi


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


alias lah='ls -lah'

