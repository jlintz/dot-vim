" start of vim-plug plugins
call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'vim-scripts/comments.vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'airblade/vim-gitgutter'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'rodjek/vim-puppet'

Plug 'Yggdroot/indentLine'

Plug 'godlygeek/tabular'

Plug 'altercation/vim-colors-solarized'

Plug 'wellle/targets.vim'

Plug 'FelikZ/ctrlp-py-matcher'
Plug 'kien/ctrlp.vim'

Plug 'majutsushi/tagbar'

Plug 'fatih/vim-go'

Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'dense-analysis/ale'

" end of vim-plug setup
call plug#end()

" behave less vi like
set nocompatible

"syntax highlighting
syntax on

" fix backspace behavior in insert mode
set backspace=indent,eol,start

"line numbers
set number

"hide buffers instead of closing them
set hidden

filetype on

set autoindent    " always set autoindenting on
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch    "search as you enter search string
set relativenumber  " relative line numbers

"longer history
set history=1000
set undolevels=1000
set undodir=~/.vim/.backup//

set wildignore=*.swp,*.bak,*.pyc,*.class

set title

"enable folding on indents
set foldmethod=indent
" don't autofold anything by default
set foldlevel=100

" none of these are word dividers
set iskeyword+=_,$,@,%,#

" highlight current line
set cursorline

" run python code
map <F5> :!python %<cr>

" sane tabstops
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" change leader key from \ to ,
let mapleader = ","

" have tab move around brackets
nnoremap <tab> %
vnoremap <tab> %

"NERDTree options
nmap <silent> <c-n> :NERDTreeToggle<CR>   " NERDTree enable with ctrl-n
nmap <silent> <c-o> :NERDTreeToggle %<CR> " Open NERDTree to the directory of the current buffer
let g:NERDTreeShowHidden=1 " show hidden files

" For all those times i forget to edit a file as root
cmap w!! %!sudo tee > /dev/null %

" moar colors plz
set t_Co=256

" enable solarized color scheme
set background=dark
colorscheme solarized

" show who to blame on the current line you are on
nmap B :ec system('git blame -L'.line('.').',+1 '.expand('%'))<CR>

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" so that some mapping still works when the cursor is at the end of file.
set virtualedit=onemore

" Show trailing whitespace:
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" tagbar
nmap <silent> <c-i> :TagbarToggle<CR>

" ALE settings
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'

let g:ale_fixers = {
      \    'python': ['black'],
      \}

" increase max file limit
let g:ctrlp_max_files=0

" ctrl-p speed ups
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'

let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

" enable ALE extensions
let g:airline#extensions#ale#enabled = 1

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <C-w>j <Plug>AirlineSelectPrevTab
nmap <C-w>k <Plug>AirlineSelectNextTab

set laststatus=2
set ttimeoutlen=50

" vim-go settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1


" highlight cloudformation templates
au BufNewFile,BufRead *.template set filetype=json

" vim-go settings

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>s <Plug>(go-implements)
"let g:go_highlight_functions = 1
"let g:go_highlight_methods = 1
"let g:go_highlight_structs = 1
"let g:go_highlight_interfaces = 1
"let g:go_highlight_operators = 1
"let g:go_highlight_build_constraints = 1

" sane tabbing for yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" terraform settings
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1

" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_completion_keys = 1

" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 0

" identLine settings
let g:indentLine_enabled = 1

