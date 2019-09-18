Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
" autozimu/LanguageClient-neovim config {{{1
let g:LanguageClient_serverCommands = {
      \ 'go': ['gopls'],
      \ }
let g:LanguageClient_changeThrottle = 0.5
let g:LanguageClient_virtualTextPrefix = "    •••➜ "
let g:LanguageClient_diagnosticsList = "Location"
let g:LanguageClient_selectionUI = "location-list"

function LC_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <buffer> <silent> g? :call LanguageClient_contextMenu()<CR>

    nnoremap <buffer> <silent> gk :call LanguageClient#textDocument_hover()<CR>
    nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <buffer> <silent> gr :call LanguageClient#textDocument_references()<CR>
    nnoremap <buffer> <silent> gR :call LanguageClient#textDocument_rename()<CR>

    set completefunc=LanguageClient#complete
    autocmd BufWritePre <buffer> :call LanguageClient#textDocument_formatting_sync()
  endif
endfunction

autocmd FileType * call LC_maps()
" }}}1

" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
