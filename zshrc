# settings
export EDITOR='nvim'
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# history
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

# completions
autoload -U compinit
compinit -C
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
    'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# prompt
parse_git_branch () {
  git branch 2> /dev/null | grep "*" | sed -e 's/* \(.*\)/(\1)/g'
}

function precmd() {
  export PROMPT="%1~$(parse_git_branch)»%b "
}

# mappings: git
alias g=git
alias gb="git branch"
alias ga='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git commit -a -m'
alias gch='git checkout'
alias gd='git diff'
alias gdw='git diff --color-words'
alias gs='git status -sb'
alias grhh='git reset --hard HEAD'
alias gcmb='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias gl='glog --graph'
alias gp='git push'
alias gpo='git push origin'
alias gpf='git push -f origin'
alias gr='git pull --rebase'
alias gri='git rebase --interactive'
# mappings: system
alias showdotfiles='defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder'
alias hidedotfiles='defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder'
alias e='exit'
alias ls='ls -Fa'
# mappings: rails
alias be='bundle exec'
alias bi='bundle install'
alias rs='rails server'
alias rc='rails console'
alias r='rails'
alias rdm='rake db:migrate'
# mappings: vim & neovim
alias vim=nvim
# mappings: xing
alias preview="ssh app-deploy@coaches-1.app.preview.fra2.xing.com"
alias ccop="coffeelint -f .coffeelint.json ./**/*.coffee"

#############################|plugins|#####################################################

# rbenv
export RBENV_ROOT="$HOME/.rbenv"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# docker
eval "$(boot2docker shellinit)"
export DOCKER_IP=$(boot2docker ip)
export DOCKER_CERT_PATH=/Users/dariusz.finster/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
export DOCKER_HOST=tcp://192.168.59.103:2376

# xing
export HERMES_SANDBOX=http://test-dariusz-finster.env.xing.com:3007

# colors
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# hub
eval "$(hub alias -s)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
