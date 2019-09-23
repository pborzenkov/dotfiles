Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
" autozimu/LanguageClient-neovim config {{{1
let g:LanguageClient_serverCommands = {
      \ 'go': ['gopls'],
      \ 'cpp': ['clangd', '-background-index'],
      \ 'c': ['clangd', '-background-index'],
      \ }

let g:LanguageClient_virtualTextPrefix = "    •••➜ "
let g:LanguageClient_diagnosticsList = "Location"

function LSP_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <buffer> <silent> g? :call LanguageClient_contextMenu()<CR>

    nnoremap <buffer> <silent> gk :call LanguageClient#textDocument_hover()<CR>
    nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <buffer> <silent> gr :call LanguageClient#textDocument_references()<CR>
    nnoremap <buffer> <silent> gR :call LanguageClient#textDocument_rename()<CR>
    nnoremap <buffer> <silent> gt :call LanguageClient#textDocument_documentSymbol()<CR>

    nmap <buffer> gD <Plug>(qf_loc_toggle)
    nmap <buffer> gn <Plug>(qf_loc_next)
    nmap <buffer> gp <Plug>(qf_loc_previous)

    set completefunc=LanguageClient#complete
    augroup LSPFormatDocument
      autocmd!
      autocmd BufWritePre <buffer> :call LanguageClient#textDocument_formatting_sync()
    augroup END
  endif
endfunction

augroup ConfigureLSP
  autocmd!
  autocmd FileType * call LSP_maps()
  autocmd User LanguageClientDiagnosticsChanged call lightline#update()
augroup END
" }}}1

" LSP help functions {{{1
function! LSPGetDiagnosticsCount(type)
  let current_buf_number = bufnr('%')
  let qflist = getloclist(0)
  let current_buf_diagnostics = filter(qflist, {index, dict -> dict['bufnr'] == current_buf_number && dict['type'] == a:type})
  return len(current_buf_diagnostics)
endfunction
" }}}1

Plug 'romainl/vim-qf'
" romainl/vim-qf config {{{1
let g:qf_mapping_ack_style = 1
let g:qf_auto_quit = 1
" }}}1

" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
