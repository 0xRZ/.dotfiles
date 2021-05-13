
" Options {{{ "
setlocal conceallevel=2
" }}} Options "

" Mappings {{{ "
nmap <buffer> gP <Plug>Markdown_MoveToParentHeader
nmap <buffer> gc <Plug>Markdown_MoveToCurHeader
nmap <buffer> gn <Plug>Markdown_MoveToNextHeader
nmap <buffer> gp <Plug>Markdown_MoveToPreviousHeader
nnoremap <buffer> gq :Toch<CR>
vnoremap <buffer> <Space>hd :HeaderDecrease<CR>
vnoremap <buffer> <Space>hi :HeaderIncrease<CR>
nnoremap <buffer> <Space>tf :TableFormat<CR>
nnoremap <buffer> ]l :<c-u>put =repeat('* ', v:count1)<cr>A
nnoremap <buffer> ]d :<c-u>put =repeat('----', v:count1)<cr>A<cr><ESC>
inoremap <buffer> <CR> <Space><Space><cr>
nnoremap <buffer> o A<Space><Space><Esc>o
nnoremap <buffer> O A<Space><Space><Esc>O
" }}} Mappingss "
