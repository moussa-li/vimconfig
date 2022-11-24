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
set clipboard+=unnamedplus
set sw=4

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

" inoremap <TAB> 4<space>

"nnoremap J 10j
"nnoremap K 10k
"nnoremap H 10h
"nnoremap L 10l
"
"vnoremap J 10j
"vnoremap K 10k
"vnoremap H 10h
"vnoremap L 10l

nmap <c-l> $
map <c-j> ^
vnoremap i k
vnoremap k j
vnoremap j h
vnoremap I 10k
vnoremap K 10j
vnoremap J 5h
vnoremap L 5l
noremap ? :nohlsearch<CR>

" 括号书名号匹配
inoremap (  ()<left>
inoremap {  {}<left>
inoremap [  []<left>
inoremap '  ''<left>
inoremap "  ""<left>
" inoremap <  <><left>
function! JumpOver(char)
    if getline(".")[col(".")-1] == a:char
	return "\<Right>"
    else
	return a:char
    endif
endfunction

function! JumpOver2(char)
    if getline(".")[col(".")-1] == a:char
	return "\<Right>"
    else
	let test = a:char . a:char . "\<Left>"
	return test
    endif
endfunction

inoremap <expr> } JumpOver('}')
inoremap <expr> ) JumpOver(')')
inoremap <expr> ' JumpOver2("'")
inoremap <expr> " JumpOver2("\"")

" 自动删除对应括号
function! DeleteOver(DO_list)
    for DO_item in a:DO_list
	if getline(".")[col(".")-2] == DO_item[0] && getline(".")[col(".")-1] == DO_item[1]
    	    return "\<BS>\<delete>"
    	endif
    endfor
    return "\<BS>"
endfunction

let DO_list = [
    	\ ["(",")"],
	\ ["{","}"],
    	\ ["[","]"],
    	\ ["\"","\""],
    	\ ["'","'"]
      \ ]
inoremap <expr> <BS>  DeleteOver(DO_list)

"==========输入法=========="
"##### auto fcitx  ###########
let g:input_toggle = 2
function! Fcitx2en()
   let s:input_status = system("fcitx5-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx5-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx5-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx5-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set ttimeoutlen=150
"退出插入模式
autocmd InsertLeave * call Fcitx2en()
"进入插入模式
autocmd InsertEnter * call Fcitx2zh()
"##### auto fcitx end ######



"========tab============"
noremap <tab> gt

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
""map <C-s> :w<CR>:source $MYVIMRC<CR>
map <C-s> :w<CR>
map f <leader><leader>s

"========plugs============="
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'cateduo/vsdark.nvim'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'easymotion/vim-easymotion'
Plug 'neoclide/coc.nvim',{'branch':'release'}
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
Plug 'puremourning/vimspector',{'do':'./install_gadget.py --enable-rust --enable-python'}

Plug 'tpope/vim-surround' "切换括号
"Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons
"Plug 'kyazdani42/nvim-tree.lua'
"中文输入法自动切换
Plug 'lyokha/vim-xkbswitch'
Plug 'ybian/smartim'

Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }

"gitsigns
Plug 'lewis6991/gitsigns.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

"注释
Plug 'b3nj5m1n/kommentary'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"终端
Plug 'skywind3000/vim-terminal-help'

call plug#end()

"========scrooloose/nerdtree=======
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-e> :NERDTreeToggle<CR>
let g:NERDTreeGitStatusIndicatorMapCustom = {
\ "Modified" : "M",
\ "Staged" : "✚",
\ "Untracked" : "✭",
\ "Renamed" : "➜",
\ "Unmerged" : "═",
\ "Deleted" : "✖",
\ "Dirty" : "✗",
\ "Clean" : "✔︎",
\ "Unknown" : "?"
\ }

let g:NERDTreeMapOpenSplit = 'h'
let g:NERDTreeMapToggleHidden = 'H'
let g:NERDTreeMapJumpFirstChild = '<c-i>'
let g:NERDTreeMapJumpLastChild = '<c-k>'
let g:NERDTreeMapJumpPrevSibling = '<c-l>'
let g:NERDTreeMapJumpNextSibling = '<c-j>'

"========cateduo/vsdark.nvim=======
"let g:vscode_style = "dark"
"colorscheme vscode
set termguicolors
let g:vsdark_style = "dark"
colorscheme vsdark

"========jackguo380/vim-lsp-cxx-highlight=======
hi default link LspCxxHlSymFunction cxxFunction
hi default link LspCxxHlSymFunctionParameter cxxParameter
hi default link LspCxxHlSymFileVariableStatic cxxFileVariableStatic
hi default link LspCxxHlSymStruct cxxStruct
hi default link LspCxxHlSymStructField cxxStructField
hi default link LspCxxHlSymFileTypeAlias cxxTypeAlias
hi default link LspCxxHlSymClassField cxxStructField
hi default link LspCxxHlSymEnum cxxEnum
hi default link LspCxxHlSymVariableExtern cxxFileVariableStatic
hi default link LspCxxHlSymVariable cxxVariable
hi default link LspCxxHlSymMacro cxxMacro
hi default link LspCxxHlSymEnumMember cxxEnumMember
hi default link LspCxxHlSymParameter cxxParameter
hi default link LspCxxHlSymClass cxxTypeAlias

"========neoclide/coc.nvim=========
let g:coc_global_extensions = [
	\ 'coc-vimlsp',
	\ 'coc-pyright',
	\ 'coc-json',
	\ 'coc-cmake',
	\ 'coc-css',
	\ 'coc-html',
	\ 'coc-highlight',
	\ 'coc-vetur',
	\]

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              "\: /"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
				  
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use space to show documentation in preview window.
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
nmap <silent> <leader>p <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>n <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


"========generation_cmake============"

function! s:generate_compile_commands()
	if empty(glob('CMakeLists.txt'))
		echo "Can't find CMakeList.txt"
		return
	endif
	if empty(glob('.vscode'))
		execute 'silent !mkdir .vscode'
	endif
	execute '!cmake -DCMAKE_BUILD_TYPE=debug
		\ -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B .vscode'
endfunction

command! -nargs=0 Gcmake :call s:generate_compile_commands()


"===========puremourning/vimspector===="
let g:vimspector_enable_mappings = "HUMAN"
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]

function! s:generate_vimspector_conf()
    if empty(glob( '.vimspector.json' ))
	if &filetype == 'c' || &filetype == 'cpp'
	    lua print("test")
	    !cp ~/.config/nvim/vimspector_conf/c.json ./.vimspector.json
	elseif &filetype == 'python'
	    !cp ~/.config/nvim/vimspector_conf/python.json ./.vimspector.json
	endif
    endif
    e .vimspector.json
endfunction

command! -nargs=0 Gvimspector :call s:generate_vimspector_conf()


"=========telescope==================="
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


"=========telescope==================="
"lua require("nvim-tree").setup()
"nnoremap <C-e> :NvimTreeToggle<CR>

"=========gitsigns==================="

lua require('gitsigns').setup()

"=========lyokha/vim-xkbswitch========="


let g:XkbSwitchLib ="/home/moussa/ProgramFiles/xkb-switch/build/libxkbswitch.so"
let g:XkbSwitchEnabled = 1


"========b3nj5m1n/kommentary=========="
lua << EOF
vim.api.nvim_set_keymap("n", "", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("v", "", "<Plug>kommentary_visual_default<C-c>", {})
require('kommentary.config').configure_language("rust", {
    single_line_comment_string = "//",
    multi_line_comment_strings = {"/*", "*/"},
})
EOF

"========JoosepAlviste/nvim-ts-context-commentstring=========="
lua << EOF
EOF
