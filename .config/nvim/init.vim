" set leader key
let mapleader=" "
nnoremap <Space> <Nop>

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))

endif

call plug#begin("~/.vim/plugged")
  " Plugin Section
  Plug 'dracula/vim'
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'junegunn/fzf.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'psliwka/vim-smoothie'
  Plug 'liuchengxu/vista.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'tpope/vim-sleuth'
call plug#end()

" Config Section
if(has("termguicolors"))
  set termguicolors
endif
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/languages/coc_setup.vim
source $HOME/.config/nvim/keys/mappings.vim

" Auto install missing packages on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
