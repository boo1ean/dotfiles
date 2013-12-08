# Connect to mysql as root
alias my="mysql -u root"

# Just shortcut for grep
alias g="grep"

# Quick lookup for running process
alias psa="ps aux | grep "

# Multi column ls with / for dirs
alias l="ls -CF"

# Clear screen
alias c="clear"

# Start http server in current directory
alias sharef="python -m SimpleHTTPServer 8080"

# Edit vimrc
alias vimrc='vim ~/.vimrc'

# Edit hosts file
alias hosts='sudo vim /etc/hosts'

# Generate ctags
alias makectags='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .'

# Open CMakeLists.txt in vim
alias ce='vim CMakeLists.txt'

# Show all groups
alias sgroups="cat /etc/group | cut -d: -f1"

# Show all users
alias susers="cat /etc/passwd | cut -d: -f1"

# Git typo
alias gi="git"
alias it="git"
alias gti="git"

# Init RVM
alias uservm='[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"'
