" Auto-installs vim-plug for neovim
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" PUT ALL PLUGINS BETWEEN plug#begin AND plug#end
" NAMES ARE 'AUTHOR/REPO_NAME' ON GITHUB REPO

call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'       " Shows signs for line modifications if file is in a git repo
Plug 'Yggdroot/indentLine'          " Visual indicator of line indent level
Plug 'google/vim-searchindex'       " / Search pattern count
Plug 'tomtom/tcomment_vim'          " comment line with gc
Plug 'jiangmiao/auto-pairs'         " Generate brackets in pairs
Plug 'vim-airline/vim-airline'      " Pretty, lightweight status line
Plug 'vim-airline/vim-airline-themes'      " Themes for airline status line
Plug 'elzr/vim-json'                " JSON highlighting
Plug 'tpope/vim-fugitive'           " Git controls inside vim    NOT USED
Plug 'vim-syntastic/syntastic'      " Syntax checking client
Plug 'vimwiki/vimwiki'              " Documentation experiment    NOT USED
Plug 'scrooloose/nerdtree'          " File tree navigation
Plug 'Xuyuanp/nerdtree-git-plugin'  " Git marks in nerdtree
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'gabrielelana/vim-markdown'    " Markdown (github) highligher
    
call plug#end()

" ### FZF ###
nnoremap <C-w>f :Files<Cr>
nnoremap <C-w>g :Rg<Cr>
" While in FZF search, enable following commands
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'up': '~40%' }  " Fzf layout. Available sides: down/up/left/right

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
"let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 1   " [Buffers] Jump to the existing window if possible

" [[B]Commits] Customize the options used by 'git log':
"let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

let g:fzf_tags_command = 'ctags -R'    " [Tags] Command to generate tags file

"let g:fzf_commands_expect = 'alt-enter,ctrl-x'   " [Commands] --expect expression for directly executing the command

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
"command! -bang -nargs=* GGrep
  "\ call fzf#vim#grep(
  "\   'git grep --line-number '.shellescape(<q-args>), 0,
  "\   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
"
" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" will not override existing commands.
command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)
"
" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
"
" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)          " Normal mode mappings
xmap <leader><tab> <plug>(fzf-maps-x)          " Visual mode mappings
omap <leader><tab> <plug>(fzf-maps-o)          " Operator-pending mode mappings

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" ### Airline ###
"    let g:airline#extensions#tabline#left_sep = ' '
"    let g:airline#extensions#tabline#left_alt_sep = '|'
"    let g:airline#extensions#tabline#formatter = 'default'

" ### Vim-wiki ###
filetype plugin on
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" ### NERDTree ###
map <C-n> :NERDTreeToggle<CR> 

" ### Conquer of Completion ###
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" GENERAL OPTIONS
set mouse=a             " Allow mouse interaction
set nocompatible        " Allow non-vi features
autocmd BufEnter * silent! lcd %:p:h  " Always change dir to the file being edited
set backspace=indent,eol,start	" Backspace over indentation, line breaks, and insertion start
set noerrorbells        " Kills the fucking system beep
set visualbell          " Replaces audio beep with visual flash. Another method to kill fucking beep
set wildmenu            " Display command line's tab complete options as a menu
set wildmode=longest:full,full
set autoread            " Enables option of re-reading files if modified inside Vim
noremap <F7> :checktime<CR> " Binds F7 to re-read file in case it changed. "autoread" needs to be set
set confirm             " Display confirmation dialog when closing an unsaved file
set formatoptions+=j    " Delete comment characters when joining lines
set hidden              " Hides buffers instead of closing them. Enables having unwritten changes and also opening a new file without being forced to write or undo your changes first
set history=500         " How many commands are saved
set undolevels=500      " How many undo steps are saved
set complete=.,w,b,u,t  " Where to look for CTRL-P suggestion while in INSERT mode
set clipboard=unnamedplus   " Cross-vim yanking
set exrc                " Enables project-specific .vimrc config
set secure              " Disables running shell scripts from project-specific config files, for security reasons.

" SEARCH OPTIONS
set ignorecase
set smartcase
set hlsearch
set incsearch

" VISUAL OPTIONS
colorscheme ron         " Set colorscheme of editor
set laststatus=2        " Always display the status bar
set background=dark     " Use colors that suit a dark background
set title               " Set the window's title, reflecting the file currently being edited
set encoding=utf-8      " Use an encoding that supports unicode
syntax enable           " Enable syntax highlighting
set ruler               " Always show cursor position

" TAB AND SHIFT OPTIONS
set autoindent			" uses the indent from the previous line
set expandtab			  " Convert tabs to spaces
set shiftround			" When shifting lines, round the indentation to nearest multiple of "shiftwidth"
set shiftwidth=2		" When shifting, indent it X spaces
set smarttab			  " Insert "tabstop" number of spaces with TAB
set tabstop=2 			" Indent using X spaces

" LINE DISPLAY
set number			        " show line number
set relativenumber  		" show relative line number
set cursorline          " Highlight the line currently under cursor
set linebreak           " Avoid wrapping a line in the midde of a word
set wrap                " Enable line wrapping (wrap/nowrap)
set scrolloff=2         " The number of screen lines to keep above and below the cursor
set sidescrolloff=5     " Number of screen columns to keep to the left and right

" DIRECTORY-RELATED OPTIONS
set backupdir=~/.cache/neovim   " Backup file directory
set dir=~/.cache/neovim         " Swap file directory
set undofile                    " Maintain undo history of files between sessions
set undodir=~/.cache/neovim     " Set directory where to store persistent undo information

" FOLDING OPTIONS
set nofoldenable	       " Disable initally folded file. zi to fold/unfold
set foldmethod=indent    " Fold based on indentation levels
set foldnestmax=3        " Only fold up to three nested levels

" FASTER WINDOW-SWITCHING
noremap <C-H> <C-W>h
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l

" Execute current file
"nnoremap <F9> :!%:p
nnoremap <leader>r :!%:p<Enter>
nnoremap <leader>R :!$TERMINAL -e %:p<Enter>

" Escalate to sudo and write
cmap w!! w !sudo -A tee % >/dev/null

" Fold with <Space>
" nnoremap <Space> za

" buffer cycling
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Make transparency work
highlight Normal ctermbg=none
highlight NonText ctermbg=none
" Make it work when changing colorschemes on the fly as well
au ColorScheme * hi Normal ctermbg=none guibg=none
au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red
