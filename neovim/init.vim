if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/vim-easy-align'      " Shorthand notation
Plug 'airblade/vim-gitgutter'       " Shows signs for line modifications if file is in a git repo
Plug 'Yggdroot/indentLine'          " Visual indicator of line indent level
Plug 'gabrielelana/vim-markdown'    " Markdown (github) highligher
Plug 'google/vim-searchindex'       " Search pattern count
Plug 'sjl/badwolf'                  " vim colorscheme
Plug 'ctrlpvim/ctrlp.vim'           " fuzzy file and buffer finder
Plug 'tomtom/tcomment_vim'          " comment line with gc
    
call plug#end()


" GENERAL OPTIONS
set backspace=indent,eol,start	" Backspace over indentation, line breaks, and insertion start
set noerrorbells        " Kills the fucking system beep
set visualbell          " Replaces audio beep with visual flash. Another method to kill fucking beep
set wildmenu            " Display command line's tab complete options as a menu
set autoread            " Enables option of re-reading files if modified inside Vim
map <F7> :checktime<CR> " Binds F7 to re-read file in case it changed. "autoread" needs to be set
set confirm             " Display confirmation dialog when closing an unsaved file
set formatoptions+=j    " Delete comment characters when joining lines
set hidden              " Hides buffers instead of closing them. Enables having unwritten changes and also opening a new file without being forced to write or undo your changes first
set history=500
set undolevels=500
set complete=.,w,b,u,t  " Where to look for CTRL-P suggestion while in INSERT mode

" VISUAL OPTIONS
colorscheme badwolf     " Set colorscheme of editor
set laststatus=2        " Always display the status bar
set background=dark     " Use colors that suit a dark background
set tabpagemax=50       " Max number of tab pages that can be opened from the command line
set title               " Set the window's title, reflecting the file currently being edited
set encoding=utf-8      " Use an encoding that supports unicode
syntax enable           " Enable syntax highlighting
set ruler               " Always show cursor position

" TAB AND SHIFT OPTIONS
set autoindent			" uses the indent from the previous line
set expandtab			" Convert tabs to spaces
set shiftround			" When shifting lines, round the indentation to nearest multiple of "shiftwidth"
set shiftwidth=4		" When shifting, indent it X spaces
set smarttab			" Insert "tabstop" number of spaces with TAB
set tabstop=4			" Indent using X spaces

" LINE DISPLAY
set number			    " show line number
set relativenumber		" show relative line number
set cursorline          " Highlight the line currently under cursor
set linebreak           " Avoid wrapping a line in the midde of a word
set wrap                " Enable line wrapping (wrap/nowrap)
set scrolloff=2         " The number of screen lines to keep above and below the cursor
set sidescrolloff=5     " Number of screen columns to keep to the left and right

" SEARCH OPTIONS
set hlsearch            " Search highlighting
set incsearch			" Start searching before pressing enter
set ignorecase          " Ignore case when searching
set smartcase           " Automatically switch search to case-sensitive when search query contains an uppercase letter

" FORCE TO LEARN VIM NAVIGATION
set mouse=			    " disable mouse
noremap <Up> <Nop>      " Disable up arrow key
noremap <Down> <Nop>    " Disable down arrow key
noremap <Left> <Nop>    " Disable left arrow key
noremap <Right> <Nop>   " Disable right arrow key

" DIRECTORY-RELATED OPTIONS
set backupdir=~/.cache/neovim   " Backup file directory
set dir=~/.cache/neovim         " Swap file directory
set undofile                    " Maintain undo history of files between sessions
set undodir=~/.cache/neovim     " Set directory where to store persistent undo information

" FOLDING OPTIONS
set nofoldenable	        " Disable initally folded file. zi to fold/unfold
set foldmethod=indent   " Fold based on indentation levels
set foldnestmax=3       " Only fold up to three nested levels





