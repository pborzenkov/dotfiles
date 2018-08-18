filetype on
filetype plugin indent on
syntax on
set ruler
set modelines=3 " check up to 3 first lines for modelines
set nocompatible

" turn the fuckin' 'beep' off
set vb t_vb=

" search options
set incsearch
set hlsearch
set ignorecase
set smartcase

set autowrite
set hidden

set noshowmode

set number
set relativenumber
nnoremap <Leader>n :set number!<CR>:set relativenumber!<CR>

map // :nohlsearch<CR>

nnoremap <C-s> :Rg <c-r>=expand("<cword>")<CR><CR>

set path=$GOPATH/src,**
set wildmenu

" netrw {{{1
let g:netrw_banner = 0
let g:netrw_liststyle = 1
" }}}1

" plugins {{{1
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
" vim-fugitive configuration {{{2
  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit -s<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap <silent> <leader>ge :Gedit<CR>
  nnoremap <silent> <leader>gr :Gread<CR>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>gq :Gwq<CR>

  function! ReviewLastCommit()
    if exists('b:git_dir')
      Gtabedit HEAD^{}
      nnoremap <buffer> <silent> q :<C-U>bdelete<CR>
    else
      echo 'No git a git repository:' expand('%:p')
    endif
  endfunction
  nnoremap <silent> <leader>g` :call ReviewLastCommit()<CR>

  augroup fugitiveSettings
    autocmd!
    autocmd FileType gitcommit setlocal nolist
    autocmd BufReadPost fugitive://* setlocal bufhidden=delete
  augroup END
" }}}2
Plug 'altercation/vim-colors-solarized'
Plug 'fatih/vim-go', { 'dir': '~/src/github.com/fatih/vim-go' }
" vim-go configuration {{{2
au FileType go nmap <Leader>B <Plug>(go-build)
au FileType go nmap <Leader>T <Plug>(go-test)
au FileType go nmap <Leader>F <Plug>(go-test-func)
au FileType go nmap <Leader>A <Plug>(go-alternate-edit)
au FileType go nmap <Leader>I <Plug>(go-info)
au FileType go nmap <Leader>C <Plug>(go-coverage-toggle)

let g:go_template_autocreate=0
let g:go_autodetect_gopath=0
let g:go_def_mode='guru'
" }}}2
Plug 'majutsushi/tagbar'
" tagbar configuration {{{2
nnoremap <Leader>G :Tagbar<CR>
autocmd FileType qf wincmd J
" }}}2
Plug 'itchyny/lightline.vim'
" lightline configuration {{{2
set laststatus=2
let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'fugitive', 'filename', 'go' ] ],
  \   'right': [ [ 'percent', 'lineinfo' ],
  \              [ 'syntastic' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'fugitive': 'LightLineFugitive',
  \   'filename': 'LightLineFilename',
  \   'syntastic': 'SyntasticStatuslineFlag',
  \   'go': 'LightLineGo',
  \ },
  \ }
function! LightLineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "RO"
  else
    return ""
  endif
endfunction

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
   \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineGo()
  return exists('*go#statusline#Show') ? go#statusline#Show() : ''
endfunction
" }}}2
Plug 'SirVer/ultisnips'
" ultisnips configuration {{{2
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
" }}}2
Plug 'easymotion/vim-easymotion'
Plug 'embear/vim-localvimrc'
Plug 'editorconfig/editorconfig-vim'
Plug 'udalov/kotlin-vim'
Plug 'hashivim/vim-terraform'
" Plug 'klen/python-mode', { 'branch': 'develop' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" {{{2
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1, <bang>0)

nnoremap <Leader>e :Files<cr>
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>r :Rg<cr>
" }}}2
Plug 'google/vim-jsonnet'
" {{{2
let g:jsonnet_fmt_options = '-n 4'
" }}}2
Plug 'cespare/vim-toml'
call plug#end()
" }}}1

" colors
set background=dark
colorscheme solarized

"
set diffopt=filler,vertical

" automatically read files again when they've been changed outside of Vim
set autoread

set fillchars+=vert:│

set spelllang=en_gb
autocmd FileType mail,gitcommit,tex,text,markdown setlocal spell
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" autocmd FileType c,go,python setlocal spell

set backspace=2

set undofile
set undodir=~/.vim_undo
set undolevels=1000
set undoreload=10000

set clipboard=unnamed

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
			\| exe "normal! g'\"" | endif

autocmd CompleteDone * pclose

" Function to source only if file exists {{{1
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction
" }}}1

" Configure cscope
if has("cscope")
  set csto=0
  set cst
  set nocsverb
  if filereadable("cscope.out")
    cs add cscope.out
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
  set csverb
endif

call SourceIfExists("~/.vimrc.local")

" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
