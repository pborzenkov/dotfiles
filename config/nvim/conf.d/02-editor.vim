Plug 'junegunn/fzf'

Plug 'junegunn/fzf.vim'
" junegunn/fzf.vim config {{{1
nnoremap <silent> <Leader>e :Files<cr>
nnoremap <silent> <Leader>b :Buffers<cr>
nnoremap <silent> <Leader>r :Rg<cr>
nnoremap <silent> <C-s> :Rg <c-r>=expand("<cword>")<CR><CR>
" }}}1

Plug 'easymotion/vim-easymotion'

" Search {{{1
set incsearch
set ignorecase
set smartcase
set hlsearch
" }}}1

" Modeline {{{1
set modelines=3
" }}}1

" Buffer management {{{1
set autowrite
set autoread
set hidden
" }}}1

" Rows numbering {{{1
set number
set relativenumber
" }}}

" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
