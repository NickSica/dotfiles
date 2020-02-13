#zmodload zsh/zprof

if [ "$(tty)" = "/dev/tty1" ]; then
	exec sway
fi

setopt appendhistory autocd extendedglob nomatch
unsetopt beep
bindkey -e

zstyle :compinstall filename '/home/nick/.zshrc'
zstyle ':completions:*' menu select

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
	compinit
done

compinit -C

source ~/.keybinds

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh-theme-powerlevel10k/config/p10k-lean.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/sudo.plugin.zsh

source /tools/Vivado/2019.2/settings64.sh

#zprof

# <<< conda initialize <<<
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/nick/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/nick/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/nick/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/nick/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

