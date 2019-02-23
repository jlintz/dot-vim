
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

let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" airline settings
set laststatus=2
set ttimeoutlen=50

" vim-go settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

" flake8 settings
let g:flake8_show_in_file=1

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
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" sane tabbing for yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" terraform settings
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1

" (Optional) Enable terraform plan to be include in filter
let g:syntastic_terraform_tffilter_plan = 1

" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_completion_keys = 1

" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 0

" identLine settings
let g:indentLine_enabled = 1

" Fix for jedi-vim with vim compiled from brew https://github.com/davidhalter/jedi-vim/issues/889
if has('mac')
    :py3 sys.executable='/usr/local/bin/python3'
endif


