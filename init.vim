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
	call plug#end()
endfunction

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	function MyVimInit()
		PlugInstall --sync
		LspInstall lua
		LspInstall bash
		LspInstall vim
		TSInstall c
		TSInstall lua
		TSInstall bash
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
nnoremap <leader>s :w<CR>
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
