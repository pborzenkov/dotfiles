Plug 'itchyny/lightline.vim'
" itchyny/lightline.vim config {{{1
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'filename' ] ],
      \   'right': [ [ 'percent', 'lineinfo' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ }
" }}}1

set laststatus=2
set noshowmode

" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
