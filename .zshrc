export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(
    git
    docker
    docker-compose
    golang
    kubectl
    tmux
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

# aliases
alias ll="ls -alh"
alias zsource="source ~/.zshrc"

if command -v nvim &> /dev/null
then
    alias vi="nvim"
else
    echo "neoVim not installed, to install run sudo pacman -S neovim"
fi

if command -v nvim &> /dev/null
then
    alias mc="mcli"
fi
if command -v yaegi &> /dev/null
then
    alias gocli="yaegi"
fi

export EDITOR=nvim
export PATH=$PATH:~/go/bin
export PATH=/usr/local/bin/:$PATH
export NVM_DIR="$HOME/.nvm"
export GOPRIVATE=github.com/Iotic-Labs/*

export HISTSIZE=999999999
export SAVEHIST=${HISTSIZE}

gcover() {
    go test -coverprofile=coverage.out ./...
    go tool cover -html=coverage.out
}

goinit () {
    local mod=$(basename $(pwd))
    go mod init github.com/teamwork/$mod
}

cd() {
    builtin cd $@
    [ -f ".env" ] && source .env
}

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Keep important stuff here!
source ~/.secrets.env
source ~/.functions.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/mcli mcli

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
