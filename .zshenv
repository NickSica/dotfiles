export LFS=/mnt/lfs
export PATH=$PATH:/usr/bin/git:~/.local/bin:~/.stack/programs/x86_64-linux/ghc-tinfo6-8.0.2/bin:~/intelFPGA_pro/19.3/modelsim_ase/bin
export TERM=termite
export ZSH_AUTOSUGGEST_USE_ASYNC=1

### For Vivado (and other Java GUIs) to run on Wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

### General aliases
alias qute="qutebrowser &"

### TODO if need be: Setup for FPGA aliases
alias ls='ls --color=auto'
alias l='ls -Fal'
