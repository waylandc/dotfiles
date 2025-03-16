
# xterm-256color is probably only used for OSX
#export TERM="xterm-256color"
export LANG="en_US.UTF-8"


if ls --help 2>&1 | grep -q -- --color
then
    alias ls='ls --color=auto -F'
    alias la='ls -la --color=auto -F'
    alias ll='ls -l --color=auto -F'
else
    alias ls='ls -FG'
    alias ll='ls -lFG'
    alias la='ls -laFG'
fi

#export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

# PS1='\h:\W \u\$ '
#PS1='\t:\w\\$\[$(tput sgr0)\]'
PS1='\e[33;1m\u@\h: \e[31m\W\e[0m\$ '
# Make bash check its window size after a process completes


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd --type f'

eval "$(direnv hook bash)"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
