#~/.bash_profile

[[ -s ~/.bashrc ]] && source ~/.bashrc

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


export PATH="$HOME/.cargo/bin:$PATH"
