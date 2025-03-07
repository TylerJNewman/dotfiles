#!/usr/bin/env zsh
# History configuration

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# History options
setopt HIST_VERIFY        # Don't execute immediately upon history expansion
setopt SHARE_HISTORY      # Share history between all sessions
setopt HIST_IGNORE_DUPS   # Don't record an entry if it's the same as previous
setopt HIST_IGNORE_ALL_DUPS # Delete old entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS  # Don't display duplicates when searching
setopt HIST_IGNORE_SPACE  # Don't record entries starting with a space
setopt HIST_SAVE_NO_DUPS  # Don't write duplicate entries in history file
setopt HIST_EXPIRE_DUPS_FIRST # Remove duplicates first when trimming history
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks from history 