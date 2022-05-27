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
vnoremap <buffer> Fd :HeaderDecrease<CR>gv
vnoremap <buffer> Fi :HeaderIncrease<CR>gv
nnoremap <buffer> <Space>Ft :TableFormat<CR>
" }}} Mappings "
