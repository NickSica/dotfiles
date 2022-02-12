export LFS=/mnt/lfs

TEMP_PATH=$PATH
unset PATH
source /opt/Xilinx/Vivado/2020.2/settings64.sh

export PATH=~/CS370/Linux/386/bin:/usr/bin/git:~/.local/bin:~/.stack/programs/x86_64-linux/ghc-tinfo6-8.0.2/bin:/opt/intelFPGA_pro/21.1/modelsim_ase/bin:~/.cargo/bin:$TEMP_PATH:$PATH
#/opt/symbiotic_20200206A/bin
export TERM=alacritty
export ZSH_AUTOSUGGEST_USE_ASYNC=1

### For Vivado (and other Java GUIs) to run on Wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

### General aliases
alias qute="qutebrowser &"
alias ls='ls --color=auto'
alias l='ls -Fal'
alias e='emacsclient -nc'
alias vim='nvim'
alias v='nvim'
alias wvnc='WAYLAND_DISPLAY=wayland-1 wayvnc 0.0.0.0 5901'

### Stop vivado throwing logs everywhere
alias vivado="vivado -nolog -nojournal"

### TODO if need be: Setup for FPGA aliases

### Symbiotic EDA
export SYMBIOTIC_LICENSE="$HOME/symbiotic_academic_license.lic"

### Sway environment setup
# This forces Intel in a multi-GPU setup
export WLR_DRM_DEVICES=/dev/dri/card0
export WLR_RENDER_DRM_DEVICE=/dev/dri/renderD128
#export WLR_RENDERER=vulkan
# These are for headless
export XDG_SESSION_TYPE=wayland
export WLR_BACKENDS=headless
#export WLR_RENDERER_ALLOW_SOFTWARE=1
export WLR_LIBINPUT_NO_DEVICES=1
