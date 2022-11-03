source ~/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# fish like completion
# antigen bundle zsh-users/zsh-completions
# antigen bundle zsh-users/zsh-autosuggestions

# Load the theme.
antigen theme kism/zsh-bira-mod

# Tell Antigen that you're done.
antigen apply

# Alias
alias please='sudo $(fc -ln -1)'
alias sudp='sudo'
alias tmux='tmux -u'
alias sl='ls'
alias nano='vim'
alias bim='echo -e "\033[0;31m\033[0;41mB\033[0mim"'
alias screen='echo no #'
alias cgrep='grep --color=always -e "^" -e'
alias youtube-dl='yt-dlp -o "%(upload_date)s %(title)s [%(id)s].%(ext)s"'

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Load up ssh keys into keychain if it is on this system
if type keychain > /dev/null; then
    sshkeylist=('id_rsa' 'id_ed25519')

    for i in $sshkeylist; do
        if [[ -e ~/.ssh/$i ]] ; then
            eval `keychain -q --eval --agents ssh $i`
        fi
    done
fi

# Keybinds
## ctrl+arrows
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
### urxvt
bindkey "\eOc" forward-word
bindkey "\eOd" backward-word

## ctrl+delete
bindkey "\e[3;5~" kill-word
### urxvt
bindkey "\e[3^" kill-word

## ctrl+backspace
bindkey '^H' backward-kill-word

## ctrl+shift+delete
bindkey "\e[3;6~" kill-line
### urxvt
bindkey "\e[3@" kill-line
