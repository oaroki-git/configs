
# Setting PATH for Python 3.11
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"
export PATH
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

alias ls="lsd -lah --group-directories-first"
alias htop="sudo htop"
alias update="source ~/.zshrc && source ~/.zprofile"
bold=$(tput bold)
normal=$(tput sgr0)
figlet -k -f graffiti "Terminal" | lolcat -p 2.3 -t