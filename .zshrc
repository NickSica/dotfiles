# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

PS1='[%n@%M %~]%# '
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100
SAVEHIST=100
setopt appendhistory autocd extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nick/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

source ~/.zshkeybinds

# Theme and Plugins for zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
#source /usr/share/zsh-theme-powerlevel10k/p10k-lean.zsh
#source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-hightlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
#source /usr/share/zsh/plugins/sudo.plugin.zsh

source /opt/Xilinx/Vivado/2020.2/settings64.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
