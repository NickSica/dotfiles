call plug#begin("~/.vim/plugged")
  " Plugin Section
  Plug 'dracula/vim'
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'lambdalisue/suda.vim'
	Plug 'tpope/vim-sleuth'
call plug#end()

" Config Section
if(has("termguicolors"))
  set termguicolors
endif

set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20

let mapleader = " "
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim
