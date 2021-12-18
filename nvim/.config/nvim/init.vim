" Plugins initialization {{{ "

let data_dir = stdpath('data') . '/site'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin()
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
" Plug 'glepnir/lspsaga.nvim'
Plug 'folke/trouble.nvim'
Plug 'folke/lua-dev.nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'rmagatti/goto-preview',
Plug 'ray-x/lsp_signature.nvim'
Plug 'ldelossa/calltree.nvim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'weilbith/nvim-code-action-menu'
" auto change cwd
Plug 'ahmedkhalf/project.nvim'

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'onsails/lspkind-nvim'

" treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'p00f/nvim-ts-rainbow'
Plug 'romgrk/nvim-treesitter-context'

" Git
Plug 'tpope/vim-fugitive'
Plug 'rhysd/git-messenger.vim'
Plug 'f-person/git-blame.nvim'
Plug 'junegunn/gv.vim'
Plug 'lewis6991/gitsigns.nvim'

" Finder/telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'sudormrfbin/cheatsheet.nvim'

" Status line
Plug 'nvim-lualine/lualine.nvim'
Plug 'SmiteshP/nvim-gps'
Plug 'arkav/lualine-lsp-progress'

" Tabs & Windows & Buffers
Plug 'akinsho/bufferline.nvim'
Plug 'famiu/bufdelete.nvim'
Plug 'romainl/vim-qf'
Plug 'kevinhwang91/nvim-bqf'
Plug 'folke/zen-mode.nvim'
Plug 'folke/twilight.nvim'

" File explorer
Plug 'kyazdani42/nvim-tree.lua'
Plug 'mcchrish/nnn.vim'
" Terminal
Plug 'kassio/neoterm'

" Debugging
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }

" Sessions
Plug 'rmagatti/session-lens'
Plug 'rmagatti/auto-session'
" open file at last editing position
Plug 'ethanholz/nvim-lastplace'

" editing
Plug 'Pocco81/AutoSave.nvim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-surround'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-commentary'
Plug 'matze/vim-move'
Plug 'godlygeek/tabular'
Plug 'jbyuki/venn.nvim'
" movement
Plug 'phaazon/hop.nvim'
Plug 'andymass/vim-matchup'
Plug 'unblevable/quick-scope'
Plug 'nacro90/numb.nvim'
" search
Plug 'mhinz/vim-grepper'
Plug 'kevinhwang91/nvim-hlslens'
Plug 'pechorin/any-jump.vim'
" info
Plug 'mbbill/undotree'
Plug 'folke/which-key.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'folke/todo-comments.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'RRethy/vim-illuminate'
Plug 'lewis6991/foldsigns.nvim'
Plug 'rhysd/vim-grammarous'
" filetype specific
Plug 'sheerun/vim-polyglot'
Plug 'tmux-plugins/vim-tmux'
" markdown
Plug 'plasticboy/vim-markdown'
if (system("uname -m") == "x86_64\n")
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
endif
" misc
Plug 'kyazdani42/nvim-web-devicons'

" Colorschemes
Plug 'Mofiqul/vscode.nvim'
" Plug 'tjdevries/gruvbuddy.nvim'
" Plug 'tjdevries/colorbuddy.vim'
" Plug 'marko-cerovac/material.nvim'
" Plug 'ishan9299/nvim-solarized-lua'
call plug#end()

if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	echom "Some modules are missing, run :PlugInstall"
	finish
endif

" }}} Plugins initialization "

" Options {{{ "

if executable('rg')
	set grepprg=rg\ --no-ignore\ --smart-case\ --no-heading
	set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
set nofixeol
set hidden
set tabstop=4
set shiftwidth=4
set tildeop
set number
set hlsearch
set termguicolors
set cursorline
set signcolumn=number
set startofline
set encoding=UTF-8
set keymap=russian-jcuken
set iminsert=0
set imsearch=-1
set timeoutlen=300
set nowrap
set pastetoggle=<F3>
autocmd InsertLeave * set nopaste
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" }}} Options "

" Mappings {{{ "

nnoremap H 0
vnoremap H 0
onoremap H 0
nnoremap L $
vnoremap L $
onoremap L $
inoremap kj <esc>
nnoremap 0 <nop>
vnoremap 0 <nop>
nnoremap $ <nop>
vnoremap $ <nop>
inoremap <esc> <nop>
vnoremap <esc> <nop>
nnoremap <c-e> 3<c-e>
nnoremap <c-y> 3<c-y>
nnoremap <c-d> 10j
nnoremap <c-u> 10k
let mapleader = "\<Space>"
nnoremap . <nop>
" '\' starts mappings for a toggle
nnoremap \u :UndotreeToggle<CR>
nnoremap <leader>a @q
nnoremap <leader>sv	:source $MYVIMRC<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sn /<c-r><c-w><CR>
vnoremap <leader>sn "hy/<c-r>h<CR>
nnoremap <leader>sy /<c-r>"<CR>
vnoremap <leader>y "+y
nnoremap <expr> <leader>y 'gg"+yG'.( line(".") == 1 ? '' : '<C-o>')
vnoremap <leader>d "_d
nnoremap <leader>p "+p
vnoremap <leader>p "_dP
nnoremap <leader>Pi :source $MYVIMRC <Bar> PlugClean <Bar> PlugInstall<cr>
nnoremap <leader>Pu :PlugUpdate<cr>:TSUpdate<cr>
nnoremap <leader>+ :resize +5<CR>
nnoremap <leader>_ :resize -5<CR>
nnoremap <leader>= :vertical resize +20<CR>
nnoremap <leader>- :vertical resize -20<CR>
nnoremap \w :set wrap!<CR>
nnoremap \l :set number!<CR>
" NOTE: might need clean vimrc with :set nocp
nnoremap \s :setlocal spell! spelllang=en,ru<CR>
nnoremap <leader>/ :noh<CR>
nnoremap <leader>W :w<CR>
nnoremap <leader>q :qa<CR>
vnoremap <leader>rr "hy:%s/<c-r>h//gc<left><left><left>
nnoremap <leader>ig :let @l=@%.":".line('.')<CR>:call setreg('+',@l)<CR>:echo @l." copied to clipboard"<CR>
nnoremap <leader>id :echo getcwd()<CR>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap [<leader> :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<leader> :<c-u>put =repeat(nr2char(10), v:count1)<cr>
inoremap <C-p> <C-r>"
onoremap w iw
onoremap q i"
onoremap Q i'

" }}} Mappings "

" Colorschemes {{{ "

function s:hl_groups_info()
	let tmpfile = tempname()	
	exe "redir > " . tmpfile
	silent hi
	redir END
	exe "tab new " . tmpfile
	set filetype=txt
endfunction
nnoremap <leader>ih :TSHighlightCapturesUnderCursor<CR>
nnoremap <leader>iH :call <SID>hl_groups_info()<CR>

set background=light

let g:vscode_style = "light"
colorscheme vscode
hi Folded guifg=#545454 guibg=#F3F3F3
hi DiagnosticHint guifg=#585858 
hi TelescopePreviewNormal guibg=#E4FFFF
hi TelescopePromptBorder   guifg=#000000
hi TelescopeSelection guifg=#5B5B5B guibg=#FFD5D5 gui=bold
hi TelescopeMultiSelection guifg=#5B5B5B guibg=#FFD5D5 gui=bold
hi TelescopeMatching       guifg=#CC241D
hi TelescopePromptPrefix   guifg=#00349B

" INFO: other themes which might be good

" let g:material_style = 'lighter'
" colorscheme material

" colorscheme solarized-flat

" lua require('colorbuddy').colorscheme('onebuddy', true)
" lua require('colorbuddy').colorscheme('colorschemes.colorsch_enhancement_onebuddy_light', true)

" }}} Colorschemes "

" LSP {{{ "

nnoremap <leader>il <cmd>LspInfo<CR>
nnoremap <leader>fl <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap \x <cmd>TroubleToggle<cr>
nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
nnoremap <leader>fp <cmd>Telescope projects<cr>
nnoremap gh <cmd>lua vim.lsp.buf.incoming_calls()<cr>

" Neovim logs at: ~/.cache/nvim/lsp.log
" vim.lsp.set_log_level("debug")
lua require('plugins_conf/conf_lspclient')

" lua << EOF
" local saga = require 'lspsaga'
" saga.init_lsp_saga()
" nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
" nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
" vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
" nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
" nnoremap <silent>gr <cmd>lua require('lspsaga.rename').rename()<CR>
" nnoremap <silent> gd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
" nnoremap <silent><leader>cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
" EOF

" preview of an LSP symbol
lua << EOF
	require('goto-preview').setup {
		width = 100,
		height = 10,
		bufhidden = "hide",
	}
EOF

" show function signature during editing 
lua << EOF
	require 'lsp_signature'.setup({
		hint_enable = false,
	})
EOF

" show function call hierarchy 
lua << EOF
	require('calltree').setup()
EOF

" show current context 
lua << EOF
	require'treesitter-context'.setup{
	    patterns = {
	        default = {
	            'for',
	            'while',
	            'if',
	            'switch',
	            'case',
	        },
	    },
	}
EOF
hi TreesitterContext guibg=#ECFFFF gui=bold

" show lightbulb when there is a code action available under cursor
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb({
	\ sign = {
	\    enabled = false,
	\ },
	\ virtual_text = {
	\   enabled = true,
	\    text = "💡",
	\   hl_mode = "replace",
	\},
\})

" }}} LSP "

" Class viewer {{{ "

nnoremap \c :SymbolsOutline<CR>
lua << EOF
vim.g.symbols_outline = {
    width = 50,
	relative_width = false,
	show_guides = false,
	auto_preview = false,
}
EOF
" }}} Class viewer "

" Cwd changer {{{ "

" change cwd to lsp's root dir or pattern
lua << EOF
require("project_nvim").setup({
	patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".root" },
})
EOF

" }}} Cwd changer "

" Completion {{{ "

set updatetime=100
set completeopt=menu,menuone,noselect
set shortmess+=c

lua require('plugins_conf/conf_completion')
" Override global configuration
autocmd FileType c,cpp,lua lua require'cmp'.setup.buffer {
\   sources = {
\   { name = 'nvim_lsp' },
\   { name = 'vsnip' },
\   { name = 'path' },
\   },
\ }

" }}} Completion "

" Treesitter {{{ "

lua require('plugins_conf/conf_treesitter')
nnoremap <leader>ft <cmd>Telescope treesitter<cr>
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99

" }}} Treesitter "

" Git {{{ "

nnoremap <leader>gb <cmd>Telescope git_branches<cr>
nnoremap <leader>fgc <cmd>Telescope git_commits<cr>
nnoremap <leader>fgb <cmd>Telescope git_bcommits<cr>
nnoremap <leader>fgs <cmd>Telescope git_status<cr>
nnoremap <leader>fgt <cmd>Telescope git_stash<cr>

" tpope/vim-fugitive
nnoremap <leader>gs :Git<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gc :Git commit<cr>
function s:rebaseStagedChanges()
	let ans = input("Is everything needed to be rebased on top of previous commit staged? y/n: ")
	if ans == 'y'
		echo "\n"
		execute "Git reset --soft HEAD~1"
		execute "Git commit --amend"
    else
        return
    endif 
endfunction
nnoremap <leader>gr :call <SID>rebaseStagedChanges()<cr>
function s:showBranchCommitDiffs()
	let branch_name = input("Base branch for which to show commits difference: ", "master")
	execute "Git log "..branch_name..".."..FugitiveHead()
endfunction
function s:showBranchDiffs()
	let branch_name = input("Base branch relative to which to show difference: ", "master")
	execute "tab Git diff "..branch_name..".."..FugitiveHead()
endfunction
nnoremap <leader>gnc :call <SID>showBranchCommitDiffs()<cr>
nnoremap <leader>gnd :call <SID>showBranchDiffs()<cr>
nnoremap <leader>gd :Git difftool<cr>
nnoremap <leader>gt :tab Git diff --staged<cr>
nnoremap <leader>gp :Git difftool -y HEAD~1 HEAD<cr>
nnoremap <leader>go :Gtabedit <c-r>"<cr>
autocmd FileType fugitive nmap <buffer> dt dp<C-w>T

" rhysd/git-messenger.vim 
let g:git_messenger_no_default_mappings = v:true
nnoremap \g :GitMessenger<cr>

" f-person/git-blame.nvim
let g:gitblame_enabled = 0
let g:gitblame_message_template = '<sha> • <summary>'
nnoremap \G :GitBlameToggle<cr>

" junegunn/gv.vim
nnoremap <leader>gl :GV --max-count=10000<cr>

" lewis6991/gitsigns.nvim
lua << EOF
require('gitsigns').setup {
  keymaps = {
    noremap = true,

    ['n ]h'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [h'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <leader>gh'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>gHs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>gHs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>gHu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>gHr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>gHr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>gHR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>gHb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    ['n <leader>gHU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
  },
}
EOF

" }}} Git "

" Finder {{{ "

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fr <cmd>Telescope live_grep<cr>
nnoremap <leader>fd <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fm <cmd>Telescope man_pages<cr>
nnoremap <leader>f' <cmd>Telescope marks<cr>
nnoremap <leader>fq <cmd>Telescope quickfix<cr>
nnoremap <leader>fj <cmd>Telescope jumplist<cr>
nnoremap <leader>f= <cmd>Telescope spell_suggest<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>
nnoremap <leader>f? <cmd>Cheatsheet<cr>
lua require('plugins_conf/conf_telescope')

" }}} Finder "

" Statusline {{{ "

lua require('plugins_conf/conf_statusline')

" }}} Statusline "

" Tabs & Windows & Buffers {{{ "

lua << EOF
require("bufferline").setup {
	options = {
		diagnostics = "nvim_lsp",
	    diagnostics_indicator = function(count, level)
			if level:match("error") then
				return "("..count..")"	
			end
		end,
		indicator_icon = '',
		close_command = "Bdelete %d",
		right_mouse_command = "Bdelete! %d",
		show_close_icon = false,
		offsets = {
			{
			    filetype = "NvimTree",
			    text = "File Explorer",
			    text_align = "center",
			},
			{
			    filetype = "Outline",
			    text = "Class viewer",
			    text_align = "center",
			},
		}
	},
}
EOF
nnoremap <silent> <leader>h :BufferLineCyclePrev<CR>
nnoremap <silent> <leader>l :BufferLineCycleNext<CR>
nnoremap <silent> <leader>< :BufferLineMovePrev<CR>
nnoremap <silent> <leader>> :BufferLineMoveNext<CR>
nnoremap <leader>d :Bwipeout<CR>
nnoremap gb :BufferLinePick<CR>
nnoremap gB :BufferLinePickClose<CR>

nnoremap <silent><leader>1 1gt
nnoremap <silent><leader>2 2gt
nnoremap <silent><leader>3 3gt
nnoremap <silent><leader>4 4gt
nnoremap <silent><leader>5 5gt
nnoremap <silent><leader>6 6gt
nnoremap <silent><leader>7 7gt
nnoremap <silent><leader>8 8gt
nnoremap <silent><leader>9 9gt
nnoremap <silent> <c-h> :e #<CR>
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
nnoremap <leader>t :tab sp<cr>
nnoremap <leader>ct :tabclose<cr>

nmap [q <Plug>(qf_qf_previous)
nmap ]q  <Plug>(qf_qf_next)
nmap \q <Plug>(qf_qf_toggle)
let g:qf_auto_open_quickfix = 0
let g:qf_auto_open_loclist = 0
let g:qf_auto_resize = 0

lua << EOF
require('bqf').setup({
	magic_window = false,
    func_map = {
		vsplit = '<c-s>',
        prevfile = '<c-k>',
        nextfile = '<c-j>',
        pscrollorig = '<c-o>',
        ptogglemode = '\\e',
    },
})
EOF

" }}} Tabs & Windows & Buffers "

" Distraction-free mode {{{ "

nnoremap \e :ZenMode<CR>
lua << EOF
	require("zen-mode").setup {
		plugins = {
		  twilight = { enabled = true },
		  gitsigns = { enabled = true },
		},
	}
	require("twilight").setup {}
EOF

" }}} Distraction-free mode "

" File explorer {{{ "

nnoremap \n :NvimTreeFindFileToggle<CR>
let g:nvim_tree_quit_on_open = 1
lua << EOF
	require('plugins_conf/conf_nvim-tree')
EOF

nnoremap <silent> \f :NnnPicker<CR>
let g:nnn#set_default_mappings = 0
let g:nnn#command = 'nnn -a -H -c -o -Q'
let g:nnn#action = {
		\ '<c-t>': 'tab split',
		\ '<c-x>': 'split',
		\ '<c-s>': 'vsplit' }

" }}} File explorer "

" Terminal {{{ "

let g:neoterm_default_mod = "botright"
let g:neoterm_autojump = 1
let g:neoterm_autoinsert = 1
let g:neoterm_automap_keys = "<Space>zx"
" nnoremap \z :Ttoggle<CR>
nnoremap \z :<c-u>exec v:count.'Ttoggle'<cr>
nnoremap <leader>zq :<c-u>exec v:count.'Tclose!'<cr>
tnoremap <silent> <c-\> <c-\><c-n>

" }}} Terminal "

" Debugger {{{ "

" let g:nvimgdb_disable_start_keymaps = v:true

" let g:nvimgdb_config_override = {
"   \ 'key_next': 'n',
"   \ 'key_step': 's',
"   \ 'key_finish': 'f',
"   \ 'key_continue': 'c',
"   \ 'key_until': 'u',
"   \ 'key_eval': 'p',
"   \ 'key_breakpoint': 'r',
"   \ }

function s:remoteGDBConn()
	let db = input("enter remote debug binary path: ")
	execute('GdbStart gdb -q -ex "target remote localhost:1234" '..db)
endfunction

nnoremap <leader>ur	:call <SID>remoteGDBConn()<CR>
nnoremap <leader>uq	:GdbDebugStop<CR>

" }}} Debugger "

" Sessions {{{ "

set sessionoptions+=winpos,terminal
nnoremap <leader>ss	:SaveSession<cr>
nnoremap <leader>fs <cmd>Telescope session-lens search_session<cr>

lua require('auto-session').setup()

"	 }}} Sessions "

" Open file on last line {{{ "

lua require'nvim-lastplace'.setup{}
let g:lastplace_ignore_buftype = "quickfix,nofile,help"
let g:lastplace_ignore_filetype = "gitcommit,gitrebase,svn,hgcommit"
let g:lastplace_open_folds = 1

" }}} Open file on last line "

" Pairs autoinserter  {{{ "

lua <<EOF
require('nvim-autopairs').setup{
	map_c_w = true,
	check_ts = true,
	ts_config = {
        {'string'},
    },
}
EOF

" }}} Pairs autoinserter "

" Auto save buffer modifications {{{ "

lua require("autosave").setup()

" }}} Auto save buffer modifications "

" Move selected blocks of text {{{ "

let g:move_map_keys = 0
vmap K <Plug>MoveBlockUp
vmap J <Plug>MoveBlockDown
vmap <C-H> <Plug>MoveBlockLeft
vmap <C-L> <Plug>MoveBlockRight

" }}} Move selected blocks of text "

" Jump to word {{{ "

nnoremap s <cmd>HopWord<CR>
vnoremap s <cmd>HopLine<CR>
nnoremap S <cmd>HopLine<CR>
noremap <c-s> <cmd>HopChar1<CR>
hi HopNextKey gui=bold,underline guifg=#ff007c
hi! link HopNextKey1 HopNextKey 
hi! link HopNextKey2 HopNextKey
lua	require'hop'.setup() 

" }}} Jump to word "

" Highlight unique characters on a line {{{ "

highlight QuickScopePrimary guibg='#FF7C7C' gui=bold,underline 
highlight QuickScopeSecondary guibg='#FF00FF' gui=bold,underline
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" }}} Highlight unique characters on a line "

" Matching bracket navigation {{{ "

let g:matchup_matchparen_offscreen = {}
hi MatchParen ctermbg=blue guibg=lightblue cterm=italic gui=italic

" }}} Matching bracket navigation "

" Jump to line number {{{ "

lua require('numb').setup()

" }}} Jump to line number "

" Search {{{ "

runtime plugin/grepper.vim
let g:grepper.prompt_quote = 2
let g:grepper.tools = ['rg', 'rg_hidden', 'git', 'grep']
let g:grepper.rg_hidden = {
    \   'grepprg': 'rg -H --no-heading --vimgrep --hidden --no-ignore',
    \ }
nnoremap <leader>r :Grepper<CR>
nnoremap <leader>R :Grepper -stop<CR>
xmap <leader>r <plug>(GrepperOperator)

noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap * *<Cmd>lua require('hlslens').start()<CR>
noremap # #<Cmd>lua require('hlslens').start()<CR>
noremap g* g*<Cmd>lua require('hlslens').start()<CR>
noremap g# g#<Cmd>lua require('hlslens').start()<CR>

let g:any_jump_disable_default_keybindings = 1
nnoremap <leader>j :AnyJump<CR>

" }}} Search "

" Show available keybindings {{{ "

lua require("which-key").setup {}

" }}} Shows available keybindings "

" Highlight todo's {{{ "

nnoremap <leader>st <cmd>TodoQuickFix<cr>
lua require("todo-comments").setup()

" }}} Highlight todo's "

" Highlight word under cursor {{{ "

function s:highlight_matches()
	hi illuminatedWord guibg=#FFC0C2
	hi! link LspReferenceText illuminatedWord
	hi! link LspReferenceRead illuminatedWord
	hi! link LspReferenceWrite illuminatedWord
endfunction
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * call <SID>highlight_matches()
augroup END
" LSP references only
nnoremap <silent> <c-j> <cmd>lua require"illuminate".next_reference{wrap=true}<CR>
nnoremap <silent> <c-k> <cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>

" }}} Highlight word under cursor "

" Indentation display {{{ "

lua << EOF
require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
	use_treesitter = true,
	context_patterns = {
		"class", "function", "method", "^if", "^do", "^while", "^for", "^struct",
	},
	char = '▏',
	-- might get slow
	viewport = 70,
}
EOF
let g:indent_blankline_filetype = ['vim', 'lua', 'sh', 'c', 'cpp']

nnoremap \t :call <SID>toggleList()<CR>
nnoremap \T :call <SID>toggleTrailing()<CR>
set lcs+=trail:⬤
set lcs+=eol:↴
function! s:toggleList()
    if !(&lcs =~ "space")
        set lcs+=space:·
    endif
	if (index(g:indent_blankline_filetype, &filetype) >= 0)
		IndentBlanklineToggle
	endif
    set list!
endfunction
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
let s:activatetw = 0
function! s:toggleTrailing()
    if s:activatetw == 0
        let s:activatetw = 1
		hi ExtraWhitespace guibg=#FF0000
    else
        let s:activatetw = 0
		hi! link ExtraWhitespace None
    endif
endfunction

" }}} Indentation  display "

" Colorizer {{{ "

lua << EOF
if jit ~= nil then
	require 'colorizer'.setup {
	  '*';
	  '!c';
	  '!cpp';
	  '!sh';
	}
end
EOF

" }}} Colorizer "

" Show signs inside of folds {{{ "

lua require('foldsigns').setup()

" }}} Show signs inside of folds "

" Notes {{{ "

let g:vim_markdown_follow_anchor = 1
nnoremap <leader>fn <cmd>lua require('telescope.builtin.files').find_files({
			\ cwd = "~/.notes",
			\ find_command = { "find", "-name", "*.md" },
			\ })<cr>

" }}} Notes "

" Draw diagrams {{{ "

nnoremap \v :lua Toggle_venn()<CR>
lua <<EOF
	function _G.Toggle_venn()
	    local venn_enabled = vim.inspect(vim.b.venn_enabled)
	    if venn_enabled == "nil" then
	        vim.b.venn_enabled = true
	        vim.cmd[[setlocal ve=all]]
	        -- draw a line
	        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
	        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
	        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
	        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
	        -- draw a box
	        vim.api.nvim_buf_set_keymap(0, "v", "b", ":VBox<CR>", {noremap = true})
	        -- draw a heavy box
	        vim.api.nvim_buf_set_keymap(0, "v", "B", ":VBox<CR>", {noremap = true})
	        -- fill with color
	        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VFill<CR>", {noremap = true})
			print("venn mode actviated")
	    else
	        vim.cmd[[setlocal ve=]]
	        vim.cmd[[mapclear <buffer>]]
	        vim.b.venn_enabled = nil
			print("venn mode disabled")
	    end
	end
EOF

" }}} Draw diagrams "
