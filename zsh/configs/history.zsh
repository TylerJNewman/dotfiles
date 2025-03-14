#!/usr/bin/env zsh
# History configuration

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# History options
setopt HIST_VERIFY SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS 
setopt HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST HIST_REDUCE_BLANKS 