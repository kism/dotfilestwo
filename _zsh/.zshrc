source ~/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme kism/zsh-bira-mod

# Tell Antigen that you're done.
antigen apply

# Alias
alias please='sudo $(fc -ln -1)'
alias sudp='sudo'
alias sl='ls'
alias nano='vim'
alias screen='echo no #'
alias cgrep='grep --color=always -e "^" -e'