# Settings
export EDITOR='vim'
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LANG=pl_PL.UTF-8
export LC_ALL=pl_PL.UTF-8
export PATH=/usr/local/bin:$PATH
export CDPATH=.:/Users/rege/Library/Mobile\ Documents/com~apple~CloudDocs

#HISTORY
HISTFILE=~/.histfile
HISTSIZE=1200
SAVEHIST=1717

autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "\e[A" up-line-or-beginning-search
bindkey "\e[B" down-line-or-beginning-search

setopt inc_append_history
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_allow_clobber

# Completions
autoload -U compinit
compinit -C
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
    'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Prompt
parse_git_branch () {
  git branch 2> /dev/null | grep "*" | sed -e 's/* \(.*\)/(\1)/g'
}

function precmd() {
  export PROMPT="%1~$(parse_git_branch)»%b "
}

# GIT
alias g=git
alias gb="git branch"
alias ga='git add .'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gcam='git commit -a -m'
alias gcm='git commit -m'
alias gd='git diff'
alias gdw='git diff --color-words'
alias gs='git status -sb'
alias gg='git grep'
alias grhh='git reset --hard HEAD'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias git-clean-merged-branches='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias glog='git log --pretty="format:%C(yellow)%h%Cblue%d%Creset %s %C(white) %an, %ar%Creset"'
alias gl='glog --graph'
alias gla='gl --all'
alias gp='git push'
alias gpu='git push -u origin'
alias gpo='git push origin'
alias gpf='git push -f origin'
alias gpr='git pull --rebase'
alias opr='hub pull-request -b gunpowderlabs/Network:master'
alias gri='git rebase --interactive'
#MAC OS
alias showallfiles='defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder'
alias hidedotfiles='defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder'
alias pmd='~/Code/pmd/pmd'
alias pomo='pmd start'
alias ss='imgur2 '
# RAILS
alias be='bundle exec'
alias bi='bundle install'
alias rs='rails server'
alias rc='rails console'
alias r='rails'
alias z='zeus'
alias pr='pry-remote'
alias rt=rspec
alias rdm="rake db:migrate"
# SYSTEM
alias c='clear'
alias e='exit'
alias ls='ls -Fa'
alias vim='mvim -v'

eval "$(boot2docker shellinit)"

export DOCKER_IP=$(boot2docker ip)
# export DOCKER_HOST=tcp://192.168.59.103:2376
# export DOCKER_CERT_PATH=/Users/rege/.boot2docker/certs/boot2docker-vm
# export DOCKER_TLS_VERIFY=1

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
