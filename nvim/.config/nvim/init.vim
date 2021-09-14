" Plugin initialization {{{ "
function! s:listPlugins()
	call plug#begin()
	Plug 'neovim/nvim-lspconfig'
	Plug 'kabouzeid/nvim-lspinstall'
    Plug 'hrsh7th/nvim-compe'
	Plug 'ahmedkhalf/lsp-rooter.nvim'
    Plug 'rmagatti/goto-preview'
	Plug 'Pocco81/AutoSave.nvim'
	" Plug 'sunjon/shade.nvim'
    " Plug 'simrat39/symbols-outline.nvim'
"	Plug 'norcalli/snippets.nvim'
    " Plug 'nvim-lua/completion-nvim'
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
	Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
"	Plug 'ray-x/lsp_signature.nvim'
"	Plug 'Shougo/echodoc.vim'
	Plug 'liuchengxu/vista.vim'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make -C deps/fzy-lua-native' }
	" Plug 'kevinhwang91/nvim-hlslens'
	Plug 'rmagatti/auto-session'
    Plug 'rmagatti/session-lens'
	Plug 'folke/todo-comments.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
	Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'
	Plug 'lukas-reineke/indent-blankline.nvim'
"    Plug 'kevinhwang91/nvim-hlslens'
	Plug 'akinsho/bufferline.nvim'
" Do not delete window when wiping out buffer within it
	Plug 'famiu/bufdelete.nvim'
	" Plug 't9md/vim-choosewin'
	Plug 'folke/which-key.nvim'
	Plug 'folke/zen-mode.nvim'
	Plug 'folke/twilight.nvim'
	Plug 'edluffy/specs.nvim'
	Plug 'ggandor/lightspeed.nvim'
	Plug 'nacro90/numb.nvim'
	Plug 'mhinz/vim-grepper'
	Plug 'tpope/vim-surround'
    Plug 'karb94/neoscroll.nvim'
	Plug 'norcalli/nvim-colorizer.lua'
    Plug 'nvim-lua/lsp-status.nvim'
	Plug 'glepnir/galaxyline.nvim'
	Plug 'kevinhwang91/nvim-bqf'
	Plug 'nvim-treesitter/playground'
	if (system("uname -m") == "x86_64\n")
		Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
		Plug 'oberblastmeister/neuron.nvim'
	endif
	Plug 'tjdevries/gruvbuddy.nvim'
	Plug 'tjdevries/colorbuddy.vim'
	Plug 'Th3Whit3Wolf/onebuddy'
	Plug 'Raimondi/delimitMate'
	Plug 'b3nj5m1n/kommentary'
	Plug 'akinsho/nvim-toggleterm.lua'
	Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    Plug 'tpope/vim-fugitive'
	Plug 'mhinz/vim-signify'
	Plug 'f-person/git-blame.nvim'
	Plug 'skywind3000/asyncrun.vim'
	Plug 'kevinhwang91/rnvimr'
	Plug 'tmux-plugins/vim-tmux'

	Plug 'marko-cerovac/material.nvim'
	Plug 'Mofiqul/vscode.nvim'
	Plug 'navarasu/onedark.nvim'

	Plug 'yamatsum/nvim-cursorline'
	call plug#end()
endfunction

" delete ~/.local/share/nvim/site/autoload/plug.vim for MyVimInit() invoke
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	function MyVimInit()
		PlugInstall --sync
		LspInstall lua
		LspInstall bash
		LspInstall vim
		LspInstall yaml
		TSInstallSync! c cpp lua bash yaml query
	endfunction
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * call MyVimInit()
	call s:listPlugins()
	finish
endif

call s:listPlugins()
" }}} Plugin initialization "

" Options {{{ "
if executable('rg')
	set grepprg=rg\ --no-ignore\ --smart-case\ --no-heading
	set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
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
set noequalalways
set nowrap
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
" nnoremap <c-e> 3<c-e>
" nnoremap <c-y> 3<c-y>
let mapleader = "\<Space>"
nnoremap . <nop>
 " filetype specific mapping
let maplocalleader = "."
" \ start mappings for a toggle
nnoremap <leader>m @q
nnoremap <leader>sv	:source $MYVIMRC<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sn /<c-r>=escape(expand("<cWORD>"), "/")<CR><CR>
vnoremap <leader>sn "hy/<c-r>h<CR>
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>p "+p
vnoremap <leader>p "_dP
nnoremap <leader>+ :resize +5<CR>
nnoremap <leader>_ :resize -5<CR>
nnoremap <leader>= :vertical resize +20<CR>
nnoremap <leader>- :vertical resize -20<CR>
nnoremap \w :set wrap!<CR>
nnoremap \n :set number!<CR>
nnoremap <leader>/ :noh<CR>
" nnoremap <leader>sf :w<CR>
nnoremap <leader>q :qa<CR>
vnoremap <leader>rr "hy:%s/<c-r>h//gc<left><left><left>
function! s:toggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
nnoremap \x :call <SID>toggleQuickFix()<CR>
nnoremap <leader>ig :let @l=@%.":".line('.')<CR>:call setreg('+',@l)<CR>:echo @l." copied to clipboard"<CR>
nnoremap <leader>sm :MarkdownPreviewToggle<CR>
nnoremap [<leader> :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<leader> :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" Which key {{{ "
lua << EOF
  require("which-key").setup {}
EOF
" }}} Which key "

" }}} Mappings "

" Colorschemes {{{ "
" lua require('colorbuddy').colorscheme('colorschemes/simple_light', true)
lua require('colorbuddy').colorscheme('onebuddy', true)
lua require('colorbuddy').colorscheme('colorschemes.colorsch_enhancement_onebuddy_light', true)

" colorscheme onedark
" let g:vscode_style = "light"
" colorscheme vscode
" let g:material_style = 'palenight'
" let g:material_italic_comments = 1
" let g:material_italic_keywords = 1
" let g:material_italic_functions = 1
" let g:material_contrast = 1

" }}} Colorschemes "

" LSP client setup, completion, treesitter {{{ "
set updatetime=100
set completeopt=menuone,noinsert,noselect
set shortmess+=c

lua << EOF
--Neovim logs at: ~/.cache/nvim/lsp.log
--vim.lsp.set_log_level("debug")
require('plugins_conf/conf_lspclient')
require('goto-preview').setup {
    width = 120; -- Width of the floating window
    height = 15; -- Height of the floating window
    default_mappings = false; -- Bind default mappings
    debug = false; -- Print debug information
    opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
    post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
  }
EOF

nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>

nnoremap <leader>il <cmd>LspInfo<CR>

function s:jumpToNextRef()
    cclose
	let v:errmsg = ""
	cnext
	if v:errmsg != ""
        cfirst
    endif
endfunction

function s:jumpToPrevRef()
    cclose
	let v:errmsg = ""
	cprev
	if v:errmsg != ""
        clast
    endif
endfunction

nnoremap <silent> <c-j> <cmd>silent! call <SID>jumpToNextRef()<CR>
nnoremap <silent> <c-k> <cmd>silent! call <SID>jumpToPrevRef()<CR>

" autocmd BufEnter * lua require'completion'.on_attach()
" imap <silent> <c-space> <Plug>(completion_trigger)
" imap <tab> <Plug>(completion_smart_tab)
" imap <s-tab> <Plug>(completion_smart_s_tab)
" let g:completion_chain_complete_list = [
"     \{'complete_items': ['lsp', 'snippet', 'path']},
"     \{'mode': '<c-p>'},
"     \{'mode': '<c-n>'}
" \]
" let g:completion_enable_snippet = 'UltiSnips'
" let g:completion_confirm_key = "\<C-j>"

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
"inoremap <c-e> <cmd>lua return require'snippets'.expand_or_advance(1)<CR>
"inoremap <c-q> <cmd>lua return require'snippets'.advance_snippet(-1)<CR>

" change cwd to lsp's root dir
lua << EOF
	require("lsp-rooter").setup{}
EOF

" nvim-treesitter {{{ "
lua << EOF
require('plugins_conf/conf_treesitter')
EOF
" }}} nvim-treesitter "

" }}} LSP client setup "

" Run snippets {{{ "
nmap <leader>sr <Plug>SnipRun
vmap <leader>sr <Plug>SnipRun
nmap <leader>sq <Plug>SnipReset
nmap <leader>sc <Plug>SnipClose
lua << EOF
require'sniprun'.setup({
  selected_interpreters = {},     --" use those instead of the default for the current filetype
  repl_enable = {},               --" enable REPL-like behavior for the given interpreters
  repl_disable = {},              --" disable REPL-like behavior for the given interpreters

  interpreter_options = {},       --" intepreter-specific options, consult docs / :SnipInfo <name>

  --" you can combo different display modes as desired
  display = {
    "Classic",                    -- "display results in the command-line  area
    -- "VirtualTextOk",              -- "display ok results as virtual text (multiline is shortened)

    -- "VirtualTextErr",          -- "display error results as virtual text
    -- "TempFloatingWindow",      -- "display results in a floating window
    -- "LongTempFloatingWindow",  -- "same as above, but only long results. To use with VirtualText__
    -- "Terminal"                 -- "display results in a vertical split
    },

  --" customize highlight groups (setting this overrides colorscheme)
  snipruncolors = {
    SniprunVirtualTextOk   =  {bg="#66eeff",fg="#000000",ctermbg="Cyan",cterfg="Black"},
    SniprunFloatingWinOk   =  {fg="#66eeff",ctermfg="Cyan"},
    SniprunVirtualTextErr  =  {bg="#881515",fg="#000000",ctermbg="DarkRed",cterfg="Black"},
    SniprunFloatingWinErr  =  {fg="#881515",ctermfg="DarkRed"},
  },

  --" miscellaneous compatibility/adjustement settings
  inline_messages = 0,             --" inline_message (0/1) is a one-line way to display messages
				   --" to workaround sniprun not being able to display anything

  borders = 'single'               --" display borders around floating windows
                                   --" possible values are 'none', 'single', 'double', or 'shadow'
})
EOF
" }}} Run snippets "

" Debugger {{{ "
let g:nvimgdb_disable_start_keymaps = v:true
function! NvimGdbNoTKeymaps()
	tnoremap <silent> <buffer> kj <c-\><c-n>
endfunction

let g:nvimgdb_config_override = {
  \ 'key_next': 'n',
  \ 'key_step': 's',
  \ 'key_finish': 'f',
  \ 'key_continue': 'c',
  \ 'key_until': 'u',
  \ 'key_eval': 'p',
  \ 'key_breakpoint': 'r',
  \ 'set_tkeymaps': "NvimGdbNoTKeymaps",
  \ }

function s:remoteGDBConn()
	let db = input("enter remote debug binary path: ")
	execute('GdbStart gdb -q -ex "target remote localhost:1234" '..db)
endfunction

nnoremap <leader>ur	:call <SID>remoteGDBConn()<CR>
nnoremap <leader>uq	:GdbDebugStop<CR>
" }}} Debugger "

" Class viewer {{{ "
nnoremap \c :Vista!!<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'nvim_lsp'
let g:vista#renderer#enable_icon = 1
let g:vista_sidebar_width = 50

" nnoremap <c-p> :SymbolsOutline<CR>
" let g:symbols_outline = {
"     \ "highlight_hovered_item": v:true,
"     \ "show_guides": v:true,
"     \ "position": 'right',
"     \ "auto_preview": v:true,
"     \ "keymaps": {
"         \ "close": "<Esc>",
"         \ "goto_location": "<Cr>",
"         \ "focus_location": "o",
"         \ "hover_symbol": "<C-space>",
"         \ "rename_symbol": "r",
"         \ "code_actions": "a",
"     \ },
"     \ "lsp_blacklist": [],
" \ }
" }}} Class viewer "

" Terminal {{{ "
lua << EOF
require("toggleterm").setup{
  size = 40,
  open_mapping = [[<c-t>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
--  direction = 'vertical' | 'horizontal' | 'window' | 'float',
  direction = 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_win_open'
    -- see :h nvim_win_open for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    border = 'shadow',
	--row = 3,
	--col = 8,
	width = 150,
    height = 20,
    winblend = 1,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
}
EOF
" }}} Terminal "

" Git integration {{{ "
function s:lineHistory()
	let line_nr = input("line number: ")
	let cmt_sha = input("commit sha to start search with: ", "HEAD")
	execute "Git blame -L "..line_nr..",+1  --ignore-rev "..cmt_sha
endfunction
nnoremap <leader>gs :Git<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gc :Git commit<cr>
nnoremap <leader>gl :Git log<cr>
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
nnoremap <leader>gt :tab Git diff --staged<cr>
nnoremap <leader>gp :Git difftool -y HEAD~1 HEAD<cr>
nnoremap <leader>gr :Git commit -m "this commit will be rebased on its parent" <Bar> Git reset --soft HEAD~1 <Bar> Git commit --amend <cr>
" nnoremap <leader>go :Gtabedit HEAD<cr>
nnoremap <leader>gd :Git difftool<cr>
let g:gitblame_enabled = 0
let g:gitblame_message_template = '<sha> • <summary>'
nnoremap \g :GitBlameToggle<cr>
nnoremap <leader>gfh :call <SID>lineHistory()<cr>
nnoremap <leader>gfs :Git show 
vnoremap <leader>gfs "hy:Git show <c-r>h<cr>
nnoremap <leader>gfl :AsyncRun -raw git log -p -S 
vnoremap <leader>gfl "hy:AsyncRun -raw git log -p -S "<c-r>h"<cr>
nnoremap <leader>gu :SignifyHunkUndo<CR>
nnoremap <leader>gh :SignifyHunkDiff<CR>
nmap [h <plug>(signify-prev-hunk)
nmap ]h <plug>(signify-next-hunk)
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
" }}} Git integration "

" Tabs & Windows & Buffers {{{ "
lua << EOF
require("bufferline").setup{}
EOF
nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>
nnoremap <silent> <leader>h :BufferLineCyclePrev<CR>
nnoremap <silent> <leader>l :BufferLineCycleNext<CR>
nnoremap <silent> <leader>< :BufferLineMovePrev<CR>
nnoremap <silent> <leader>> :BufferLineMoveNext<CR>
" Close the current buffer and move to the previous one
nnoremap <leader>d :Bwipeout<CR>
" Switch a buffer
nnoremap gb :BufferLinePick<CR>
" Delete a buffer
nnoremap <silent> gB :BufferLinePickClose<CR>
" Toggle previous buffer switch
nmap <silent> <c-h> :e #<CR>
" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
" Put window to new tab
nnoremap <leader>t :tab sp<cr>
" close
nnoremap <leader>ct :tabclose<cr>

lua << EOF
require('bqf').setup({
    auto_enable = true,
    preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border_chars = {'┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█'}
    },
    func_map = {
        prevfile = '<c-k>',
        nextfile = '<c-j>',
        pscrollorig = '<c-o>',
        pscrollup = '<c-u>',
        pscrolldown = '<c-d>',
        ptogglemode = '\\e',
    },
})
EOF

" lua <<EOF
" require'shade'.setup({
"   overlay_opacity = 55,
"   opacity_step = 1,
"   keys = {
"     brightness_up    = '<C-Up>',
"     brightness_down  = '<C-Down>',
"     toggle           = '\\d',
"   }
" })
" EOF
" }}} Tabs & Windows & Buffers "

" Statusline {{{ "
lua require('plugins_conf/conf_statusline')
" }}} Statusline "

" Finder {{{ "
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fr <cmd>Telescope live_grep<cr>
nnoremap <leader>fd <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fm <cmd>Telescope man_pages<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>
nnoremap <leader>fl <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <leader>fs <cmd>Telescope session-lens search_session<cr>
nnoremap <leader>f. <cmd>lua require('plugins_conf/conf_telescope').search_dotfiles()<cr>
nnoremap <leader>fgc <cmd>Telescope git_commits<cr>
nnoremap <leader>fgl <cmd>Telescope git_bcommits<cr>
nnoremap <leader>fgs <cmd>Telescope git_status<cr>
nnoremap <leader>fgt <cmd>Telescope git_stash<cr>
if (system("uname -m") == "x86_64\n")
nnoremap <leader>fz <cmd>lua require'neuron/telescope'.find_zettels()<CR>
endif
lua << EOF
require('plugins_conf/conf_telescope')
EOF

" Navigation aid {{{ "
nnoremap <leader>xt <cmd>TodoQuickFix<cr>
lua << EOF
require("todo-comments").setup {
}
EOF
" }}} Navigation aid "

" }}} Finder "

" File explorer {{{ "
let g:nvim_tree_width = 40
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', '*.o' ]
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
nnoremap \f :NvimTreeToggle<CR>
nnoremap <leader>nr :NvimTreeRefresh<CR>
nnoremap <leader>nn :NvimTreeFindFile<CR>
tnoremap <silent> \e <C-\><C-n>:RnvimrResize<CR>
nnoremap <silent> \r :RnvimrToggle<CR>
tnoremap <silent> \r <C-\><C-n>:RnvimrToggle<CR>
" }}} File explorer "

" Search {{{ "
runtime plugin/grepper.vim
let g:grepper = {
    \ 'tools': ['rg', 'rg_hidden', 'git', 'grep', 'ag'],
    \ 'rg_hidden': {
    \   'grepprg':    'rg -H --no-heading --vimgrep --hidden',
    \ }}
nnoremap <leader>re :Grepper<CR>
xmap <leader>re <plug>(GrepperOperator)

" noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
"             \<Cmd>lua require('hlslens').start()<CR>
" noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
"             \<Cmd>lua require('hlslens').start()<CR>
" noremap * *<Cmd>lua require('hlslens').start()<CR>
" noremap # #<Cmd>lua require('hlslens').start()<CR>
" noremap g* g*<Cmd>lua require('hlslens').start()<CR>
" noremap g# g#<Cmd>lua require('hlslens').start()<CR>
" }}} Search "

" Editing aid {{{ "

" Motion aid {{{ "
" nnoremap <c-a> :HopWord<CR>
" nnoremap <c-s> :HopLine<CR>
" nnoremap <c-v> <cmd>HopChar1<CR>
" vnoremap <c-v> <cmd>HopChar1<CR>
" hi HopNextKey gui=bold,underline guifg=#ff007c
" hi! link HopNextKey1 HopNextKey 
" hi! link HopNextKey2 HopNextKey


hi! link LightspeedMaskedChar LightspeedLabel 
" " hi! link LightspeedUnlabeledMatch LightspeedLabel 

lua <<EOF
require'lightspeed'.setup {
  jump_to_first_match = false,
  jump_on_partial_input_safety_timeout = 400,
  -- This can get _really_ slow if the window has a lot of content,
  -- turn it on only if your machine can always cope with it.
  highlight_unique_chars = true,
  grey_out_search_area = true,
  match_only_the_start_of_same_char_seqs = true,
  limit_ft_matches = 4,
  full_inclusive_prefix_key = '<c-e>',
  -- By default, the values of these will be decided at runtime,
  -- based on `jump_to_first_match`.
  labels = nil,
  cycle_group_fwd_key = nil,
  cycle_group_bwd_key = nil
}
EOF
" Jump to line while typing in :
lua require('numb').setup()
" }}} Motion aid "

" Indentation display {{{ "
set lcs+=trail:⬤
set lcs+=eol:↴
hi NonText guifg=#fd0000
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_context_patterns = ['class', 'function', 'method', '^if', '^do', '^while', '^for', '^struct']
let g:indent_blankline_char = '▏'
let g:indent_blankline_filetype = ['vim', 'lua', 'bash', 'c', 'cpp']
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
nnoremap \t :call <SID>CheckWhitespaces()<CR>
" }}} Indentation  display "

" Autoinsert delimiters {{{ "
let delimitMate_excluded_ft = "markdown"
" }}} Autoinsert delimiters "

" Focus mode {{{ "

lua << EOF
	require("zen-mode").setup {
		plugins = {
			twilight = { enabled = false }
		},
		-- callback where you can add custom code when the Zen window opens
  		on_open = function(win)
			require('specs').toggle()	
  		end,
  		-- callback where you can add custom code when the Zen window closes
  		on_close = function()
			require('specs').toggle()	
  		end,
	}
	require("twilight").setup {
	}
EOF
nmap \e :ZenMode<CR>
nmap \d :Twilight<CR>
" }}} Focus mode "

" Autosave {{{ "
lua << EOF
local autosave = require("autosave")
autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)
EOF
" }}} Autosave "

" }}} Editing aid "

" Beautifiers {{{ "

" Show cursor {{{ "
lua << EOF
require('specs').setup{ 
    show_jumps  = true,
    min_jump = 5,
    popup = {
        delay_ms = 0, -- delay before popup displays
        inc_ms = 10, -- time increments used for fade/resize effects 
        blend = 40, -- starting blend, between 0-100 (fully transparent), see :h winblend
        width = 40,
        winhl = "JumpHiglight",
        fader = require('specs').exp_fader,
        resizer = require('specs').slide_resizer,
    },
    ignore_filetypes = {},
    ignore_buftypes = {
        nofile = true,
    },
}
EOF

" augroup CursorWordHighlight
"   autocmd!
"   autocmd Filetype,BufEnter help execute 'echom "he;;o"'
" augroup END
" let g:cursorword_highlight = v:false
" }}} Show cursor "

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

" Smooth scroll {{{ "
let g:smooth_scroll_toogle_var = v:true 
function s:toogle_smthscrll() abort
		if (g:smooth_scroll_toogle_var)
				nnoremap <C-u> <C-u>
				nnoremap <C-d> <C-d>
				nnoremap <C-b> <C-b>
				nnoremap <C-f> <C-f>
				nnoremap zz zz
		else
				lua require('neoscroll').setup({ mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zz',},})
		endif
		let g:smooth_scroll_toogle_var = !g:smooth_scroll_toogle_var
endfunction
nnoremap \s :call <SID>toogle_smthscrll()<cr>
" lua << EOF
" require('neoscroll').setup({
"     mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zz',},
" })
" EOF
" }}} Smooth scroll "

" }}} Beautifiers "

" Notes {{{ "
if (system("uname -m") == "x86_64\n")
lua << EOF
require'neuron'.setup {}
EOF
endif
" }}} Notes "

" Sessions {{{ "

lua << EOF
local opts = {
  log_level = 'info',
  auto_session_enable_last_session = false,
  auto_session_enabled = true,
  auto_save_enabled = nil,
  auto_restore_enabled = nil,
  auto_session_suppress_dirs = nil
}
require('auto-session').setup(opts)
EOF
set sessionoptions+=options,resize,winpos,terminal
" set sessionoptions-=blank
set sessionoptions-=folds
nnoremap <leader>ss	:SaveSession<cr>

"	 }}} Sessions "
