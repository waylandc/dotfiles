
export TERM="xterm-256color"

if ls --help 2>&1 | grep -q -- --color
then
    alias ls='ls --color=auto -F'
else
    alias ls='ls -FG'
fi

export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

# PS1='\h:\W \u\$ '
PS1='\e[33;1m\u@\h: \e[31m\W\e[0m\$ '
# Make bash check its window size after a process completes
shopt -s checkwinsize

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"


# Nix
#if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
#  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
#fi
# End Nix

