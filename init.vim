" Plugin & LSP servers initialization {{{ "
function! s:listPlugins()
	call plug#begin()
	Plug 'neovim/nvim-lspconfig'
	Plug 'kabouzeid/nvim-lspinstall'
	Plug 'hrsh7th/nvim-compe'
	Plug 'norcalli/snippets.nvim'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make -C deps/fzy-lua-native' }
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'kyazdani42/nvim-web-devicons', {'do': 'Firas=(\"https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf\" \"https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Bold/complete/Fira%20Code%20Bold%20Nerd%20Font%20Complete.ttf\" \"https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Light/complete/Fira%20Code%20Light%20Nerd%20Font%20Complete.ttf\" \"https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/SemiBold/complete/Fira%20Code%20SemiBold%20Nerd%20Font%20Complete.ttf\") && mkdir -p ~/.local/share/fonts && for i in ${Firas[@]}; do echo wget -O ~/.local/share/fonts/$(basename $i \| tr -s %20 -) $i; done'}
    Plug 'kyazdani42/nvim-tree.lua'
	Plug 'norcalli/nvim-colorizer.lua'
	Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
    Plug 'kevinhwang91/nvim-hlslens'
    Plug 'mihaifm/bufstop'
    Plug 'moll/vim-bbye'
	Plug 'folke/which-key.nvim'
	Plug 'kdav5758/TrueZen.nvim'
	Plug 'edluffy/specs.nvim'
	Plug 'phaazon/hop.nvim'
    Plug 'karb94/neoscroll.nvim'
	call plug#end()
endfunction

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	function MyVimInit()
		PlugInstall --sync
		LspInstall lua
		LspInstall bash
		LspInstall vim
		LspInstall yaml
		TSInstall c
		TSInstall lua
		TSInstall bash
		TSInstall yaml
		source $MYVIMRC
	endfunction
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * call MyVimInit()
	call s:listPlugins()
	finish
endif

call s:listPlugins()
" }}} Plugin & LSP servers initialization "

" LSP client setup {{{ "
set updatetime=200
set completeopt=menuone,noselect

lua << EOF
--Neovim logs at: ~/.cache/nvim/lsp.log
--vim.lsp.set_log_level("debug")
require('plugins_conf/conf_lspclient')
EOF

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <c-e> <cmd>lua return require'snippets'.expand_or_advance(1)<CR>
inoremap <c-q> <cmd>lua return require'snippets'.advance_snippet(-1)<CR>
" }}} LSP client setup "

" Options {{{ "
set nofixeol
set hidden
set tabstop=4
set number
set hlsearch
set termguicolors
set signcolumn=number
set scroll=10
set startofline
set encoding=UTF-8
set timeoutlen=300
" }}} Options "

" Mappings {{{ "
nnoremap H 0
vnoremap H 0
nnoremap L $
vnoremap L $
inoremap kj <esc>
nnoremap 0 <nop>
vnoremap 0 <nop>
nnoremap $ <nop>
vnoremap $ <nop>
inoremap <esc> <nop>
vnoremap <esc> <nop>
nnoremap <c-e> 3<c-e>
nnoremap <c-y> 3<c-y>
vnoremap <c-d> <c-d>zz
vnoremap <c-u> <c-u>zz
let mapleader ="\<Space>"
nnoremap <leader>; }
nnoremap <leader>g {
nnoremap <leader>sn /<c-r>=escape(expand("<cWORD>"), "/")<CR><CR>
vnoremap <leader>sn "hy/<c-r>h<CR>
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>p "+p
vnoremap <leader>p "_dP
nnoremap <leader>= :vertical resize +20<CR>
nnoremap <leader>- :vertical resize -20<CR>
nnoremap <leader>w :set wrap!<CR>
nnoremap <leader>/ :noh<CR>
nnoremap <leader>sf :w<CR>
nnoremap <leader>q :qa<CR>
vnoremap <leader>r "hy:%s/<c-r>h//gc<left><left><left>
nnoremap [<leader> :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<leader> :<c-u>put =repeat(nr2char(10), v:count1)<cr>
" }}} Mappings "

" Finder {{{ "
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fm <cmd>Telescope man_pages<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>
nnoremap <leader>fs <cmd>Telescope lsp_workspace_symbols query= <cr>
nnoremap <leader>fd <cmd>lua require('plugins_conf/conf_telescope').search_dotfiles()<cr>
lua << EOF
require('plugins_conf/conf_telescope')
EOF
" }}} Finder "

" nvim-treesitter {{{ "
lua << EOF
require('plugins_conf/conf_treesitter')
EOF
" }}} nvim-treesitter "

" File explorer {{{ "
let g:nvim_tree_width = 40
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', '*.o' ]
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_special_files = [ 'README.md', 'Makefile', 'MAKEFILE' ]
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }
lua << EOF
require('plugins_conf/conf_nvim-tree')
EOF
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>nr :NvimTreeRefresh<CR>
nnoremap <leader>nn :NvimTreeFindFile<CR>
" }}} File explorer "

" Colorizer {{{ "
lua << EOF
require 'colorizer'.setup {
  'css';
  'javascript';
  'vim';
  html = {
    mode = 'foreground';
  };
  'conf'
}
EOF
" }}} Colorizer "

" Indentation display {{{ "
set lcs+=trail:⬤
set lcs+=eol:↴
hi NonText guifg=#fd0000
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_current_context = v:true
highlight IndentBlanklineContextChar ctermfg=160 guifg=#d70000
let g:indent_blankline_context_patterns = ['class', 'function', 'method', '^if', '^do', '^while', '^for', '^struct']
hi IndentBlanklineCharHighlightListFirstLevel ctermfg=34 guifg=#00af00
hi IndentBlanklineCharHighlightListSecondLevel ctermfg=35 guifg=#00af5f
hi IndentBlanklineCharHighlightListThirdLevel ctermfg=36 guifg=#00af87
hi IndentBlanklineCharHighlightListFourthLevel ctermfg=37 guifg=#00afaf
hi IndentBlanklineCharHighlightListFifthLevel ctermfg=38 guifg=#00afd7
hi IndentBlanklineCharHighlightListSixtLevel ctermfg=39 guifg=#00afff
hi IndentBlanklineCharHighlightListSeventLevel ctermfg=111 guifg=#87afff
hi IndentBlanklineCharHighlightListEigthLevel ctermfg=110 guifg=#87afd7
let g:indent_blankline_char = '▏'
let g:indent_blankline_char_highlight_list = [
			\'IndentBlanklineCharHighlightListFirstLevel',
			\'IndentBlanklineCharHighlightListSecondLevel',
			\'IndentBlanklineCharHighlightListThirdLevel',
			\'IndentBlanklineCharHighlightListFourthLevel',
			\'IndentBlanklineCharHighlightListFifthLevel',
			\'IndentBlanklineCharHighlightListSixtLevel',
			\'IndentBlanklineCharHighlightListSeventLevel',
			\'IndentBlanklineCharHighlightListEigthLevel',
			\]
let g:indent_blankline_show_end_of_line = v:true
"might get slow
let g:indent_blankline_viewport_buffer = 70
function! s:CheckWhitespaces()
    if !(&lcs =~ "space")
        set lcs+=space:·
    endif
    IndentBlanklineToggle
    set list!
endfunction
nnoremap <leader>sw :call <SID>CheckWhitespaces()<CR>
" }}} Indentation  display "

" Search {{{ "
noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap * *<Cmd>lua require('hlslens').start()<CR>
noremap # #<Cmd>lua require('hlslens').start()<CR>
noremap g* g*<Cmd>lua require('hlslens').start()<CR>
noremap g# g#<Cmd>lua require('hlslens').start()<CR>
" }}} Search "

" Tabs & Windows & Buffers {{{ "
let g:BufstopDismissKey = "q"
let g:BufstopKeys = "1234asfcvzx5wertyuiopbnm67890ABCEFGHIJKLMNOPRSTUVZ"
nnoremap <leader>l :BufstopForward<CR>
" Move to the previous buffer
nnoremap <leader>h :BufstopBack<CR>
" Switch a buffer
nnoremap <leader>b :BufstopPreview<CR>
" Switch buffer fast
nnoremap <leader>a :BufstopModeFast<CR>
" Close the current buffer and move to the previous one
nnoremap <leader>d :Bwipeout<CR>

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
" Put window to new tab
noremap <c-t> :tab sp<cr>
" }}} Tabs & Windows & Buffers "

" Which key {{{ "
lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF
" }}} Which key "

" Focus mode {{{ "
lua require("true-zen").setup({ataraxis = { force_when_plus_one_window = true }})
map <F12> :TZAtaraxis<CR>
" }}} Focus mode "

" Hop {{{ "
nnoremap <c-a> :HopWord<CR>
nnoremap <c-s> :HopLine<CR>
hi HopNextKey1 gui=bold,underline guifg=#ff007c
hi! link HopNextKey2 HopNextKey1
" }}} Hop "

" Smooth scroll {{{ "
lua << EOF
require('neoscroll').setup({
    -- All these keys will be mapped. Pass an empty table ({}) for no mappings
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
                '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing = false,              -- easing_function will be used in all scrolling animations with some defaults
    easing_function = function(x) return math.pow(x, 2) end -- default easing function
})
local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
t['<C-u>'] = {'scroll', {'-10', 'true', '8'}}
t['<C-d>'] = {'scroll', { '10', 'true', '8'}}
t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '7'}}
t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '7'}}
t['<C-y>'] = {'scroll', {'-0.10', 'false', '20'}}
t['<C-e>'] = {'scroll', { '0.10', 'false', '20'}}
t['zt']    = {'zt', {'7'}}
t['zz']    = {'zz', {'7'}}
t['zb']    = {'zb', {'7'}}
require('neoscroll.config').set_mappings(t)
EOF
" }}} Smooth scroll "
