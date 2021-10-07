" Misc {{{ "
" echo char2nr(" ")
" Sb: bold
let b:surround_98 = "**\r**"
" Si: italics
let b:surround_105 = "*\r*"
" Sl: link
let b:surround_108 = "[[\r]]"
" Sh: header
let b:surround_104 = "## \r #"

" }}} Misc "

" Options {{{ "
setlocal conceallevel=2
" }}} Options "

" Mappings {{{ "
nnoremap <buffer> \p :MarkdownPreviewToggle<CR>
nmap <buffer> gP <Plug>Markdown_MoveToParentHeader
nmap <buffer> gC <Plug>Markdown_MoveToCurHeader
nmap <buffer> gn <Plug>Markdown_MoveToNextHeader
nmap <buffer> gp <Plug>Markdown_MoveToPreviousHeader
nnoremap <buffer> <Space>xh :Toch<CR>
vnoremap <buffer> <Space>hd :HeaderDecrease<CR>
vnoremap <buffer> <Space>hi :HeaderIncrease<CR>
nnoremap <buffer> <Space>tf :TableFormat<CR>
nnoremap <buffer> ]l :<c-u>put =repeat('* ', v:count1)<cr>A
nnoremap <buffer> ]d :<c-u>put =repeat('----', v:count1)<cr>A<cr><ESC>
" }}} Mappings "
