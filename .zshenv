export LFS=/mnt/lfs

TEMP_PATH=$PATH
unset PATH
source /opt/Xilinx/Vivado/2020.2/settings64.sh

export PATH=~/CS370/Linux/386/bin:/usr/bin/git:~/.local/bin:~/.stack/programs/x86_64-linux/ghc-tinfo6-8.0.2/bin:~/intelFPGA_pro/19.3/modelsim_ase/bin:$TEMP_PATH:$PATH
#/opt/symbiotic_20200206A/bin
export TERM=termite
export ZSH_AUTOSUGGEST_USE_ASYNC=1

### For Vivado (and other Java GUIs) to run on Wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

### General aliases
alias qute="qutebrowser &"
alias ls='ls --color=auto'
alias l='ls -Fal'
alias e='emacsclient'
alias vim='nvim'
alias v='nvim'

### Stop vivado throwing logs everywhere
alias vivado="vivado -nolog -nojournal"

### TODO if need be: Setup for FPGA aliases

### Symbiotic EDA
export SYMBIOTIC_LICENSE="$HOME/symbiotic_academic_license.lic"

### Sway environment variables for headless
export WLR_DRM_DEVICES=/dev/dri/card0
export WLR_BACKENDS=headless
export WLR_LIBINPUT_NO_DEVICES=1
