# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

# Disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Show in the command execution time stamp in the history command output.
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Fire some scripts
source $HOME/.aliases
source $HOME/.env
source $HOME/.z.sh

# Node version manager setup
export PATH=/home/kmenux/.fnm:$PATH
eval "`fnm env --multi`"

if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init -)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
