# settings
export EDITOR='vim'
export TERM=xterm-256color
# export CLICOLOR=1
# export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
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

# right prompt: vi mode
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

# left prompt: cmd
parse_git_branch () {
  git branch 2> /dev/null | grep "*" | sed -e 's/* \(.*\)/(\1)/g'
}

function precmd() {
  export PROMPT="%1~$(parse_git_branch)»%b "
}

# Use jk for ESC
bindkey -M viins 'jk' vi-cmd-mode

# mappings: git
alias g=git
alias gb="git branch"
alias ga='git add'
alias gA='git add .'
alias gc='git commit'
alias go='git checkout'
alias gd='git diff'
alias gs='git status -sb'
alias grhh='git reset --hard HEAD'
alias gclean='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias glog='git log --pretty="format:%C(yellow)%h%Cblue%d%Creset %s %C(white) %an, %ar%Creset"'
alias gl='glog --graph'
alias gp='git push'
alias gpo='git push origin'
alias gpf='git push -f origin'
alias gr='git pull --rebase'
alias gri='git rebase --interactive'
alias gg='git grep -i'
alias stash='git stash'
alias unstash='git stash pop'
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
alias rt=rspec
# mappings: vim & neovim
alias vim=nvim
# mappings: xing
alias preview="ssh app-deploy@coaches-1.app.preview.fra2.xing.com"
alias production="ssh app-deploy@coaches-1.app.fra2.xing.com"
alias worker="ssh app-deploy@coaches-1.worker.preview.fra2.xing.com"
alias daario="ssh vagrant@daario-dariusz-finster.env.xing.com"
alias viper="ssh vagrant@viper-dariusz-finster.env.xing.com"
alias jamie="ssh vagrant@jamie-dariusz-finster.env.xing.com"
alias ccop="coffeelint -f .coffeelint.json ./**/*.coffee"
alias jcf='RAILS_ENV=test rake javascript_fixtures:create'

#############################|plugins|#####################################################

# rbenv
export RBENV_ROOT="$HOME/.rbenv"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# colors
BASE16_SHELL="$HOME/.config/base16-shell/base16-3024.light.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# functions
function gon {
  gbs | nl
  echo 'Which branch: '
  read branch_number
  branch_name=$(gbs | awk "NR==$branch_number" | tr -d ' ')
  git checkout $branch_name
}
