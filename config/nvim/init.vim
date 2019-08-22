call plug#begin('~/.local/share/nvim/site/plugged')
runtime! conf.d/*.vim
call plug#end()

let g:solarized_termtrans=1
set background=dark
silent! colorscheme solarized

" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
