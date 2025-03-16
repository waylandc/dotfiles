# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.cargo/bin:/usr/local/bin:$PATH
export PATH="$HOME/mybin:$HOME/Downloads/parity-binaries:$HOME/work/protoc-3.6.1-osx-x86_64/bin:$HOME/go/bin:$PATH"
# below openssl and ruby added for macos ruby only
export PATH="/usr/local/opt/openssl@1.1/bin:$HOME/.gem/ruby/2.6.3/bin:$PATH"

# set DISPLAY for 
export DISPLAY=$(ifconfig en0 | awk '/inet /{print $2 ":0"}')

# Path to your oh-my-zsh installation.
export ZSH="/Users/waylandchan/.oh-my-zsh"

fpath=(/usr/share/zsh/$ZSH_VERSION/functions/ $fpath)

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "gentoo" "agnoster" "smt" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git cargo fzf rust nvm brew)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
# else
#   export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Wayland's customizations
#

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

alias canvpn='ssh -i ~/Documents/aws/canada-vpn.pem ubuntu@99.79.100.14'
alias hkec2='ssh -i ~/Documents/aws/hk-ec2-substrate.pem ubuntu@ec2-18-162-125-246.ap-east-1.compute.amazonaws.com'
alias proto='protoc --go_out=. *.proto'
alias offlinegodoc='godoc -http=:6060'
# open firefox allowing me to select profile
alias ffpm='/Applications/Firefox.app/Contents/MacOS/firefox-bin -P -no-remote &!'
alias em='emacsclient -t -a "" -c "$@"'

export LC_ALL=en_US.UTF-8

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  # nix environment variables
  . $HOME/.nix-profile/etc/profile.d/nix.sh
fi

eval "$(direnv hook zsh)"

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

RPROMPT="%{$fg[yellow]%}[%@]"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/waylandchan/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/waylandchan/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/waylandchan/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/waylandchan/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
