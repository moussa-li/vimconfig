syntax on
let mapleader="t"
set cursorline
set number
set relativenumber
set wrap
set showcmd
set wildmenu

set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase

map ; :
noremap h i
noremap H I

nnoremap i k
nnoremap k j
nnoremap j h
nnoremap I 10k
nnoremap K 10j
nnoremap J 5h
nnoremap L 5l
nmap <c-l> $
nmap <c-j> ^
vnoremap i k
vnoremap k j
vnoremap j h
vnoremap I 10k
vnoremap K 10j
vnoremap J 5h
vnoremap L 5l
noremap ? :nohlsearch<CR>

"========splite============"
map <A-l> :set splitright<CR>:vsplit<CR>
map <A-j> :set nosplitright<CR>:vsplit<CR>
map <A-i> :set nosplitbelow<CR>:split<CR>
map <A-k> :set splitbelow<CR>:split<CR>

map <leader>i <C-w>k
map <leader>k <C-w>j
map <leader>j <C-w>h
map <leader>l <C-w>l

map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

"========others============"
map <C-s> :w<CR>:source $MYVIMRC<CR>

"========plugs============="
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'cateduo/vsdark.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

"========scrooloose/nerdtree=======
"nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-e> :NERDTreeToggle<CR>
let g:NERDTreeGitStatusIndicatorMapCustom = {
\ "Modified" : "✹",
\ "Staged" : "✚",
\ "Untracked" : "✭",
\ "Renamed" : "➜",
\ "Unmerged" : "═",
\ "Deleted" : "✖",
\ "Dirty" : "✗",
\ "Clean" : "✔︎",
\ "Unknown" : "?"
\ }

"========cateduo/vsdark.nvim=======
set termguicolors
let g:vsdark_style = "dark"
"colorscheme vsdark

"========neoclide/coc.nvim=========
let g:coc_global_extensions = [
	\ 'coc-vimlsp',
	\ 'coc-pyright',
	\]

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> <space> :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

"nnoremap <silent><nowait> <leader>d :CocList diagnostics<CR>
nmap <silent> <leader>e <Plug>(coc-diagnostic-prev)
"nmap <silent> <leader>k <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
