" Misc {{{ "
" echo char2nr(" ")
" bold
let b:surround_98 = "**\r**"
" italics
let b:surround_105 = "*\r*"
" link
let b:surround_108 = "[[\r]]"
" header
let b:surround_104 = "## \r #"
" }}} Misc "

" Options {{{ "
setlocal conceallevel=2
" }}} Options "

" Mappings {{{ "
nmap <buffer> gP <Plug>Markdown_MoveToParentHeader
nmap <buffer> gC <Plug>Markdown_MoveToCurHeader
nmap <buffer> gn <Plug>Markdown_MoveToNextHeader
nmap <buffer> gp <Plug>Markdown_MoveToPreviousHeader
nnoremap <buffer> gq :Toch<CR>
vnoremap <buffer> <Space>hd :HeaderDecrease<CR>
vnoremap <buffer> <Space>hi :HeaderIncrease<CR>
nnoremap <buffer> <Space>tf :TableFormat<CR>
nnoremap <buffer> ]l :<c-u>put =repeat('* ', v:count1)<cr>A
nnoremap <buffer> ]d :<c-u>put =repeat('----', v:count1)<cr>A<cr><ESC>
nmap <buffer> <Space>p "+P`[v`]<CR>
" }}} Mappings "
