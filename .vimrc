
" behave less vi like
set nocompatible

"syntax highlighting
syntax on

"line numbers
set number

"hide buffers instead of closing them
set hidden

filetype on
" in human-language files, automatically format everything at 72 chars:
autocmd FileType mail,human set formatoptions+=t textwidth=72

set autoindent    " always set autoindenting on
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch    "search as you enter search string

" have <esc> remove search highlighting
"nnoremap <silent> <esc> :noh<return><esc>

"longer history
set history=1000
set undolevels=1000

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

" wrap at 79 chars
" set textwidth=79

" run python code
map <F5> :!python %<cr>

" sane tabstops
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" Use pathogen to easily modify the runtime path to include all
" " plugins under the ~/.vim/bundle directory
call pathogen#helptags()
call pathogen#infect()

" change leader key from \ to ,
let mapleader = ","

" have tab move around brackets
nnoremap <tab> %
vnoremap <tab> %

" NERDTree enable with ctrl-n
nmap <silent> <c-n> :NERDTreeToggle<CR>

" For all those times i forget to edit a file as root
cmap w!! %!sudo tee > /dev/null %

" sweet status line
set laststatus=2
if has('statusline')
  set statusline=%<%f\
  set statusline+=%w%h%m%r
  set statusline+=%{fugitive#statusline()}
  set statusline+=\ [%{&ff}/%Y]
  set statusline+=\ [%{getcwd()}]
  set statusline+=%=%-14.(Line:\ %l\ of\ %L\ [%p%%]\ -\ Col:\ %c%V%)
endif

" minbufexplorer options
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1

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

" disable quickfix window
let g:pyflakes_use_quickfix = 0

" run pep8 on file
let g:pep8_map='<leader>8'

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
