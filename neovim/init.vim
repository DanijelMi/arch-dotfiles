call plug#begin('~/.config/nvim/plugged')

" Introduces sensible set-option defaults, good as a starting point
Plug 'tpope/vim-sensible' 

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Markdown (github) highligher
Plug 'gabrielelana/vim-markdown'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'


call plug#end()

set number	" show line number
set relativenumber	" show relative line number
set mouse=a	" enable mouse
set foldenable	" enable folding
set autowrite	" save on buffer switch
" set nowrap	" don't wrap lines
