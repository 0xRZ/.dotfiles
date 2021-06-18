" Plugin initialization {{{ "
function! s:listPlugins()
	call plug#begin()
	Plug 'neovim/nvim-lspconfig'
	Plug 'kabouzeid/nvim-lspinstall'
    Plug 'hrsh7th/nvim-compe'
    " Plug 'simrat39/symbols-outline.nvim'
"	Plug 'norcalli/snippets.nvim'
    " Plug 'nvim-lua/completion-nvim'
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
"	Plug 'ray-x/lsp_signature.nvim'
"	Plug 'Shougo/echodoc.vim'
	Plug 'liuchengxu/vista.vim'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make -C deps/fzy-lua-native' }
	Plug 'rmagatti/auto-session'
    Plug 'rmagatti/session-lens'
	Plug 'folke/todo-comments.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'kyazdani42/nvim-web-devicons', {'do': 'Firas=(\"https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf\" \"https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Bold/complete/Fira%20Code%20Bold%20Nerd%20Font%20Complete.ttf\" \"https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Light/complete/Fira%20Code%20Light%20Nerd%20Font%20Complete.ttf\" \"https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/SemiBold/complete/Fira%20Code%20SemiBold%20Nerd%20Font%20Complete.ttf\") && mkdir -p ~/.local/share/fonts && for i in ${Firas[@]}; do wget -O ~/.local/share/fonts/$(basename $i \| tr -s %20 -) $i; done'}
    Plug 'kyazdani42/nvim-tree.lua'
	Plug 'norcalli/nvim-colorizer.lua'
	Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
"    Plug 'kevinhwang91/nvim-hlslens'
    Plug 'mihaifm/bufstop'
    Plug 'moll/vim-bbye'
	Plug 'folke/which-key.nvim'
	Plug 'kdav5758/TrueZen.nvim'
	Plug 'edluffy/specs.nvim'
	Plug 'phaazon/hop.nvim'
	Plug 'mhinz/vim-grepper'
	Plug 'tpope/vim-surround'
    Plug 'karb94/neoscroll.nvim'
    Plug 'nvim-lua/lsp-status.nvim'
	Plug 'glepnir/galaxyline.nvim'
	Plug 'kevinhwang91/nvim-bqf'
	Plug 'nvim-treesitter/playground'
	" Plug 'npxbr/glow.nvim', {'do': 'git clone https://github.com/charmbracelet/glow.git && cd glow && go build && mv glow $HOME/go/bin','branch':'main'}
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
	if (system("uname -m") == "x86_64\n")
	Plug 'oberblastmeister/neuron.nvim'
	endif
	Plug 'Raimondi/delimitMate'
	Plug 'yamatsum/nvim-cursorline'
	Plug 'b3nj5m1n/kommentary'
	Plug 'akinsho/nvim-toggleterm.lua'
	Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    Plug 'tpope/vim-fugitive'
	Plug 'mhinz/vim-signify'
	Plug 'f-person/git-blame.nvim'
	Plug 'rhysd/clever-f.vim'
	Plug 'skywind3000/asyncrun.vim'

	Plug 'tjdevries/colorbuddy.vim'
	Plug 'Th3Whit3Wolf/onebuddy'
    Plug 'tjdevries/gruvbuddy.nvim'
	Plug 'marko-cerovac/material.nvim'
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
		TSInstall query
		source $MYVIMRC
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
" \ and <Space>. start mappings for a toggle
map \ <leader>.
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
nnoremap <leader>= :vertical resize +20<CR>
nnoremap <leader>- :vertical resize -20<CR>
nnoremap <leader>.r :set wrap!<CR>
nnoremap <leader>/ :noh<CR>
nnoremap <leader>sf :w<CR>
nnoremap <leader>q :qa<CR>
vnoremap <leader>rr "hy:%s/<c-r>h//gc<left><left><left>
nnoremap <leader>re :Grepper<CR>
nnoremap <leader>oq :copen<CR>
xmap <leader>re <plug>(GrepperOperator)
nnoremap <leader>sm :MarkdownPreviewToggle<CR>
nnoremap [<leader> :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<leader> :<c-u>put =repeat(nr2char(10), v:count1)<cr>
" }}} Mappings "

" Colorschemes {{{ "
" lua require('colorbuddy').colorscheme('colorschemes/simple_light', true)
lua require('colorbuddy').colorscheme('onebuddy', true)
lua require('colorbuddy').colorscheme('colorschemes.colorsch_enhancement_light', true)
" let g:material_style = 'palenight'
" let g:material_italic_comments = 1
" let g:material_italic_keywords = 1
" let g:material_italic_functions = 1
" let g:material_contrast = 1

" " Load the colorsheme
" colorscheme material
" }}} Colorschemes "

" LSP client setup, completion {{{ "
set updatetime=100
set completeopt=menuone,noinsert,noselect
set shortmess+=c

lua << EOF
--Neovim logs at: ~/.cache/nvim/lsp.log
--vim.lsp.set_log_level("debug")
require('plugins_conf/conf_lspclient')
EOF

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
" }}} LSP client setup "

" nvim-treesitter {{{ "
lua << EOF
require('plugins_conf/conf_treesitter')
EOF
" }}} nvim-treesitter "

" Indentation display {{{ "
set lcs+=trail:⬤
set lcs+=eol:↴
hi NonText guifg=#fd0000
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_context_patterns = ['class', 'function', 'method', '^if', '^do', '^while', '^for', '^struct']
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
nnoremap <leader>.w :call <SID>CheckWhitespaces()<CR>
" }}} Indentation  display "

" Class viewer {{{ "
nnoremap <c-p> :Vista!!<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'nvim_lsp'
let g:vista#renderer#enable_icon = 1

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
      border = "TerminalBorders",
      background = "TerminalWindow",
    }
  }
}
EOF
nnoremap <silent><c-t> :<c-u>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-t> <Esc>:<c-u>exe v:count1 . "ToggleTerm"<CR>
" }}} Terminal "

" Run snippets {{{ "
nmap <leader>sr <Plug>SnipRun
vmap <leader>sr <Plug>SnipRun
nmap <leader>sq <Plug>SnipReset
nmap <leader>sc <Plug>SnipClose
lua << EOF
require'sniprun'.setup({
--  selected_interpreters = {},     --" use those instead of the default for the current filetype
--  repl_enable = {},               --" enable REPL-like behavior for the given interpreters
--  repl_disable = {},              --" disable REPL-like behavior for the given interpreters

  inline_messages = 0,             --" inline_message (0/1) is a one-line way to display messages
                                  --" to workaround sniprun not being able to display anything

  -- " you can combo different display modes as desired
  display = {
    --"Classic",                    -- "display results in the command-line  area
    "VirtualTextOk",              -- "display ok results as virtual text (multiline is shortened)
    "VirtualTextErr",          -- "display error results as virtual text
    -- "TempFloatingWindow",      -- "display results in a floating window
    --"LongTempFloatingWindow",  -- "same as above, but only long results. To use with VirtualText__
    "Terminal"                 -- "display results in a vertical split
  },
})
EOF
" }}} Run snippets "

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
nnoremap <leader>gt :tab Git diff --staged<cr>
nnoremap <leader>gp :Git difftool -y HEAD~1 HEAD<cr>
nnoremap <leader>gr :Git commit -m "rebase this commit" <Bar> Git rebase -i HEAD~2<cr>
" nnoremap <leader>go :Gtabedit HEAD<cr>
nnoremap <leader>gd :Git difftool<cr>
let g:gitblame_enabled = 0
let g:gitblame_message_template = '<sha> • <summary>'
nnoremap <leader>.g :GitBlameToggle<cr>
nnoremap <leader>gfh :call <SID>lineHistory()<cr>
nnoremap <leader>gfc :Git show 
vnoremap <leader>gfc "hy:Git show <c-r>h<cr>
nnoremap <leader>gfl :AsyncRun -raw git log -p -S 
vnoremap <leader>gfl "hy:AsyncRun -raw git log -p -S "<c-r>h"<cr>
nnoremap <leader>gu :SignifyHunkUndo<CR>
nnoremap <leader>gh :SignifyHunkDiff<CR>
nmap [h <plug>(signify-prev-hunk)
nmap ]h <plug>(signify-next-hunk)
" }}} Git integration "

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

nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
" Put window to new tab
nnoremap <leader>t :tab sp<cr>
" close
nnoremap <leader>ct :tabclose<cr>

lua <<EOF
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
        ptogglemode = '<Space>t',
    },
})
EOF
" }}} Tabs & Windows & Buffers "

" Statusline {{{ "
lua require('plugins_conf/conf_statusline')
" }}} Statusline "

" Finder {{{ "
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fr <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fm <cmd>Telescope man_pages<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>
nnoremap <leader>fl <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <leader>fs <cmd>Telescope session-lens search_session<cr>
nnoremap <leader>fd <cmd>lua require('plugins_conf/conf_telescope').search_dotfiles()<cr>
nnoremap <leader>fgc <cmd>Telescope git_commits<cr>
nnoremap <leader>fgl <cmd>Telescope git_bcommits<cr>
nnoremap <leader>fgs <cmd>Telescope git_status<cr>
nnoremap <leader>fgb <cmd>Telescope git_branches<cr>
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
nnoremap <leader>.f :NvimTreeToggle<CR>
nnoremap <leader>nr :NvimTreeRefresh<CR>
nnoremap <leader>nn :NvimTreeFindFile<CR>
" }}} File explorer "

" Search {{{ "
let g:grepper = {}
let g:grepper.tools =
  \ ['rg', 'git', 'grep', 'ag']
"noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
"            \<Cmd>lua require('hlslens').start()<CR>
"noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
"            \<Cmd>lua require('hlslens').start()<CR>
"noremap * *<Cmd>lua require('hlslens').start()<CR>
"noremap # #<Cmd>lua require('hlslens').start()<CR>
"noremap g* g*<Cmd>lua require('hlslens').start()<CR>
"noremap g# g#<Cmd>lua require('hlslens').start()<CR>
" }}} Search "

" Colorizer {{{ "
lua << EOF
require 'colorizer'.setup {
  '*';
  '!c';
  '!cpp';
  '!sh';
}
EOF
" }}} Colorizer "

" Which key {{{ "
lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF
" }}} Which key "

" Motion aid {{{ "
nnoremap <c-a> :HopWord<CR>
nnoremap <c-s> :HopLine<CR>
nnoremap <c-v> <cmd>HopChar1<CR>
vnoremap <c-v> <cmd>HopChar1<CR>
hi HopNextKey gui=bold,underline guifg=#ff007c
hi! link HopNextKey1 HopNextKey 
hi! link HopNextKey2 HopNextKey
" }}} Motion aid "

" Editing aid {{{ "

" Autoinsert delimiters {{{ "
let delimitMate_excluded_ft = "markdown"
" }}} Autoinsert delimiters "

" }}} Editing aid "

" Focus mode {{{ "
lua << EOF
require("true-zen").setup({
		ataraxis = { force_when_plus_one_window = true },
		integrations = {
		   integration_galaxyline = true,
		}
		})
EOF
map <leader>.e :TZAtaraxis<CR>
" }}} Focus mode "

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
nnoremap <leader>.s :call <SID>toogle_smthscrll()<cr>
lua << EOF
require('neoscroll').setup({
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zz',},
})
EOF
" }}} Smooth scroll "

" Notes {{{ "
if (system("uname -m") == "x86_64\n")
lua << EOF
require'neuron'.setup {}
EOF
endif
" }}} Notes "

" Sessions {{{ "
function s:saveSession()
	let sess_name = input("session name: ")
	let sess_name = stdpath('data').."/sessions/"..sess_name..".vim"
	execute "mksession! " . sess_name 
endfunction
lua << EOF
require('auto-session').setup()
EOF
nnoremap <leader>se :call <SID>saveSession()<CR>
"	 }}} Sessions "
