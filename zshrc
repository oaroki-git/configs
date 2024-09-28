# aliases
alias ls="lsd -a --group-directories-first"
alias activate_pyvenv="source ~/Documents/pvenv/bin/activate"

# history
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# fast cd
setopt auto_cd

# completions
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# integrations
source "${HOME}/.zgen/zgen.zsh"
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"

# zgen
zgen load zsh-users/zsh-autosuggestions
zgen load zsh-users/zsh-completions
zgen load zsh-users/zsh-syntax-highlighting

#startup
echo
fm6000 -c "random" -r -p=69
