""" General Settings
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search

""" Indentation Settings
set tabstop=2               " Insert 2 spaces for a tab
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
"set expandtab               " Converts tabs to spaces
set shiftwidth=2            " Change the number of space characters inserted for indentation
set smarttab                " Makes tabbing smarter will realize you have 2 vs 4
set smartindent             " Makes indenting smart
set autoindent              " Good auto indent
set showtabline=2           " Always show tabs
filetype plugin indent on   " allow auto-indenting depending on file type
filetype plugin on

""" Other settings I haven't categorized
"set spell                  " enable spell check (may need to download language package)
"set noswapfile             " disable creating swap file
"set backupdir=~/.cache/vim " Directory to store backup files.
syntax enable               " Enables syntax highlighing
set hidden                  " Required to keep multiple buffers open multiple buffers
set nowrap                  " Display long lines as just one line
set encoding=utf-8          " The encoding displayed
set pumheight=10            " Makes popup menu smaller
set fileencoding=utf-8      " The encoding written to file
set ruler              			" Show the cursor position all the time
set cmdheight=2             " More space for displaying messages
set iskeyword+=-            " treat dash separated words as a word text object"
set mouse=a                 " Enable your mouse
set splitbelow              " Horizontal splits will automatically be below
set splitright              " Vertical splits will automatically be to the right
set t_Co=256                " Support 256 colors
set conceallevel=0          " So that I can see `` in markdown files
set laststatus=0            " Always display the status line
set number                  " Line numbers
set cursorline              " Enable highlighting of the current line
set background=dark         " tell vim what the background color looks like
"set noshowmode              " We don't need to see things like -- INSERT -- anymore
set nobackup                " This is recommended by coc
set nowritebackup           " This is recommended by coc
set updatetime=300          " Faster completion
set timeoutlen=500          " By default timeoutlen is 1000 ms
set formatoptions-=cro      " Stop newline continution of comments
set ttyfast                 " Speed up scrolling in Vim
set clipboard=unnamedplus   " Copy paste between vim and everything else
"set cc=80                   " Set an 80 column border
"set autochdir               " Your working directory will always be the same as your working directory

autocmd filetype python setlocal expandtab shiftwidth=4 softtabstop=4

au! BufWritePost $MYVIMRC source % " auto source when writing to init.vim alternatively you can run :source $MYVIMRC

" Allows forced sudo- first line doesn't work
"cmap w!! w !sudo tee %
cnoreabbrev w!! SudaWrite

colorscheme dracula
