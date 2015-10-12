# Display banner
if [ -f "$HOME/.banner" ]; then
  cat "$HOME/.banner"
fi
if [ -f "$HOME/.built" ]; then
  cat "$HOME/.built"
fi

export PS1="\[\e[32;1m\]> \[\e[0m\]"

# Alias definitions.
alias df='df -h'
alias du='du -h'
alias ls='ls -p'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
