# Paths
export ZSH="/home/donsly/.oh-my-zsh"
export PATH="${PATH}:${HOME}/.local/bin/:$HOME/.config/composer/vendor/bin"

# ! Install spaceship theme
ZSH_THEME="spaceship"
SPACESHIP_CHAR_SYMBOL="五 "

# Plugins
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Aliases
alias zshconfig="nvim ~/.zshrc"
alias xup="xrdb ~/.Xresources"
alias todo="nvim ~/Dev/todo.md"
alias vim="nvim"
alias cat="bat"
