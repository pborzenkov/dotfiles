Plug 'itchyny/lightline.vim'
" itchyny/lightline.vim config {{{1

let g:lightline = {}

let g:lightline.colorscheme = 'solarized'
let g:lightline.active = {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'filename' ],
    \             [ 'error', 'warning', 'info', 'hint'] ],
    \   'right': [ [ 'percent', 'lineinfo' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ }
let g:lightline.inactive = {
    \   'left': [ [ 'filestate' ] ],
    \   'right': [ [ 'percent', 'lineinfo' ] ]
    \ }

let g:lightline.component_expand = {
    \ 'error': 'LightlineLSPErrors',
    \ 'warning': 'LightlineLSPWarnings',
    \ 'info': 'LightlineLSPInfos',
    \ 'hint': 'LightlineLSPHints',
    \ }

let g:lightline.component_type = {
    \ 'error': 'error',
    \ 'warning': 'warning',
    \ 'info': 'info',
    \ 'hint': 'hint',
    \ }

function! LightlineLSPErrors() abort
  let count = LSPGetDiagnosticsCount('E')
  return count > 0 ? 'E:' . count : ''
endfunction

function! LightlineLSPWarnings() abort
  let count = LSPGetDiagnosticsCount('W')
  return count > 0 ? 'W:' . count : ''
endfunction

function! LightlineLSPInfos() abort
  let count = LSPGetDiagnosticsCount('I')
  return count > 0 ? 'I:' . count : ''
endfunction
function! LightlineLSPHints() abort
  let count = LSPGetDiagnosticsCount('H')
  return count > 0 ? 'H:' . count : ''
endfunction
" }}}1

set laststatus=2
set noshowmode

" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
