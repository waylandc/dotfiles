
export TERM="xterm-256color"
export LANG="en_US.UTF-8"
export PATH="$HOME/mybin:$HOME/Downloads/parity-binaries:$HOME/work/protoc-3.6.1-osx-x86_64/bin:$HOME/go/bin:$PATH"

if ls --help 2>&1 | grep -q -- --color
then
    alias ls='ls --color=auto -F'
    alias la='ls -la --color=auto -F'
    alias ll='ls -l --color=auto -F'
    alias canvpn='ssh -i ~/Documents/aws/canada-vpn.pem ubuntu@99.79.100.14'
    alias hkec2='ssh -i ~/Documents/aws/hk-ec2-substrate.pem ubuntu@ec2-18-162-125-246.ap-east-1.compute.amazonaws.com'
else
    alias ls='ls -FG'
    alias canvpn='ssh -i ~/Documents/aws/canada-vpn.pem ubuntu@99.79.100.14'
    alias hkec2='ssh -i ~/Documents/aws/hk-ec2-substrate.pem ubuntu@ec2-18-162-125-246.ap-east-1.compute.amazonaws.com'
    alias ll='ls -lFG'
    alias la='ls -laFG'
fi

#export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go -error $?)"
}

if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# Wayland's aliases
alias proto='protoc --go_out=. *.proto'

# PS1='\h:\W \u\$ '
#PS1='\t:\w\\$\[$(tput sgr0)\]'
#PS1='\e[33;1m\u@\h: \e[31m\W\e[0m\$ '
# Make bash check its window size after a process completes
shopt -s checkwinsize

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd --type f'

if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  # nix environment variables
  . $HOME/.nix-profile/etc/profile.d/nix.sh
fi

eval "$(direnv hook bash)"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
