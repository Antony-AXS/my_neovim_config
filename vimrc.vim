" call plug#begin()
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Plug 'https://github.com/neoclide/coc.nvim'
" Plug 'https://github.com/tpope/vim-surround'
" Plug 'https://github.com/ap/vim-css-color'
" Plug 'https://github.com/rafi/awesome-vim-colorSchemes'
" Plug 'https://github.com/tc50cal/vim-terminal'
" call plug#end()

" set nu
" set rnu
"set ignorecase
" set mouse=
" set display=lastline
"set laststatus=3
"set winheight=500
"set mouse=a
"set mousescroll=ver:1 
"map <ScrollWheelDown> j
"map <ScrollWheelUp> k

" nnoremap <C-q> :TerminalSplit bash<CR>
" 
" inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<c-g>u\<CR>"

"if has("persistent_undo")
"   let target_path = expand('~/.undodir')
"
"    " create the directory and any parent directories
"    " if the location does not exist.
"    if !isdirectory(target_path)
"        call mkdir(target_path, "p", 0700)
"    endif
"
"    let &undodir=target_path
"    set undofile
"endif
"
"if !exists('g:undotree_WindowLayout')
"    let g:undotree_WindowLayout = 2
"endif
"
let g:vim_dadbod_completion_mark = 'MYMARK'

set laststatus =2
set statusline +=\ %1*\ %f\ %* 
"set statusline +=\ %1*
set statusline +=\ %l:%L
set statusline +=\ %m 
set statusline +=%=
set statusline +=\ Buf-No:
set statusline +=%n
set statusline +=\ <<
set statusline +=\ %l:%c
set statusline +=\ >>

