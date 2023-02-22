#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias ll="ls -alh"

if command -v nvim &> /dev/null
then
    alias vi="nvim"
else
    echo "neoVim not installed, to install run sudo pacman -S neovim"
fi

# Use mycli as a nicer mysql client
if command -v mycli &> /dev/null
then
    alias mysql="mycli"
else
    echo "mycli not installed, to install run yay -S mycli"
fi

export EDITOR=nvim
export PATH=$PATH:~/go/bin
export NVM_DIR="$HOME/.nvm"

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
source /usr/share/git/completion/git-completion.bash
source /etc/bash_completion.d/docker-compose

# Keep important stuff here!
source ~/.secrets.env

zsh

complete -C /usr/local/bin/mcli mcli
