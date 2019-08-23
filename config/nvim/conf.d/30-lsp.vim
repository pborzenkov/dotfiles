Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
" autozimu/LanguageClient-neovim config {{{1
let g:LanguageClient_serverCommands = {
      \ 'go': ['gopls'],
      \ 'c': ['clangd', '-background-index'],
      \ 'cpp': ['clangd', '-background-index'],
      \ }

function LC_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <buffer> <silent> g? :call LanguageClient_contextMenu()<CR>

    nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
    nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>

    autocmd BufWritePre <buffer> :call LanguageClient#textDocument_formatting_sync()
  endif
endfunction

autocmd FileType * call LC_maps()
" }}}1

" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
