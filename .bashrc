
export TERM="xterm-256color"

export PATH="$HOME/Downloads/parity-binaries:$HOME/work/protoc-3.6.1-osx-x86_64/bin:$HOME/go/bin:$PATH"

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

export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

# Wayland's aliases
alias proto='protoc --go_out=. *.proto'

# powerline
function _update_ps1() {
  PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
  PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# PS1='\h:\W \u\$ '
PS1='\t:\w\\$\[$(tput sgr0)\]'
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


#python setup

# activate virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# create commands to override pip restriction.
# use `gpip` or `gpip3` to force installation of
# a package in the global python environment
gpip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
gpip3(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

# end python setup

eval "$(direnv hook bash)"

