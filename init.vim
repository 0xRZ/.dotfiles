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
    Plug 'Xuyuanp/scrollbar.nvim'
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
set lcs+=trail:⬤
set lcs+=eol:↴
hi NonText guifg=#fd0000
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
nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz
vnoremap <c-d> <c-d>zz
vnoremap <c-u> <c-u>zz
let mapleader ="\<Space>"
nnoremap <leader>bs /<c-r>=escape(expand("<cWORD>"), "/")<CR><CR>
vnoremap <leader>bs "hy/<c-r>h<CR>
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

" Scrollbar {{{ "
augroup ScrollbarInit
  autocmd!
  autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
  autocmd WinLeave,FocusLost             * silent! lua require('scrollbar').clear()
augroup end
" }}} Scrollbar "
