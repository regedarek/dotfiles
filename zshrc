# settings
export EDITOR='nvim'
export TERM=tmux-256color
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="/usr/local/sbin:$PATH"
export GMAIL_PASSWORD=wvbaxuvxkqxlbzrx
export DOTPAY_PASSWORD=ochotnic4
export GITHUB_USERNAME="regedarek"

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
alias gg='echo "########### RESULTS ###########" && git grep -in'
alias stash='git stash'
alias unstash='git stash pop'
alias gt='git for-each-ref --sort="-*authordate" --format="%(tag) - %(taggerdate:short)%0a%(contents)" refs/tags | less'
alias grl='git log --oneline --grep=Merge --since "2 weeks ago"'
# mappings: system
alias mux=tmuxinator
alias showdotfiles='defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder'
alias hidedotfiles='defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder'
alias e='exit'
alias ls='ls -Fa'
alias vim=nvim
# mappings: rails
alias be='bundle exec'
alias bi='bundle install'
alias rs='bundle exec rails server'
alias rc='bundle exec rails console'
alias r='bundle exec rails'
alias t=tmux
alias v=vim
alias s=ssh
alias rdm='bundle exec rake db:migrate'
alias :e=vim
alias :qa=exit
alias :sp='test -n "$TMUX" && tmux split-window'
alias :vs='test -n "$TMUX" && tmux split-window -h'
alias :wq=exit

#############################|plugins|#####################################################

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

source "$HOME/.config/nvim/pack/minpac/start/gruvbox/gruvbox_256palette.sh"

function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N fg-bg
bindkey '^Z' fg-bg

source $HOME/.zsh/colors

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
alias ctags="`brew --prefix`/bin/ctags"
