" start of vim-plug plugins
let g:ale_disable_lsp = 1

let g:coc_global_extensions = [
    \  'coc-python',
    \  'coc-json',
    \  'coc-yaml',
    \  'coc-sh',
    \  'coc-html',
    \  'coc-css'
    \]

call plug#begin()

Plug 'vim-python/python-syntax'
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
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'ryanoasis/vim-devicons' " always at bottom

call plug#end() " end of vim-plug setup

" additional colors
set t_Co=256

set encoding=utf-8
"set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline\ 14

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
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
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

" NERDTree options
nmap <silent> <c-n> :NERDTreeToggle<CR>   " NERDTree enable with ctrl-n
nmap <silent> <c-o> :NERDTreeToggle %<CR> " Open NERDTree to the directory of the current buffer
let NERDTreeQuitOnOpen = 1

" For all those times i forget to edit a file as root
cmap w!! %!sudo tee > /dev/null %

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
let g:ale_sign_error = '✘'
let g:ale_sign_warning = ''
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

" airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#ale#enabled = 1 " enable ALE extensions
let g:airline#extensions#coc#enabled = 1 " coc status


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

" highlight cloudformation templates
au BufNewFile,BufRead *.template set filetype=json

" vim-python enable
let g:python_highlight_all = 1

" sane tabbing for yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" terraform settings
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1
let g:terraform_completion_keys = 1 " (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_registry_module_completion = 0 " (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion

" identLine settings
let g:indentLine_enabled = 1

"coc configuration

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" end coc config

" devicons configuration
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_statusline = 1 " airline
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:WebDevIconsUnicodeDecorateFileNodes = 1

