local actions = require('telescope.actions')

require('telescope').setup{
    defaults = {
		mappings = {
    	  i = {
    	    -- To disable a keymap, put [map] = false
    	    ["<c-x>"] = false,
    	    ["<c-n>"] = false,
    	    ["<c-j>"] = actions.move_selection_next,
    	    ["<c-p>"] = false,
    	    ["<c-k>"] = actions.move_selection_previous,
    	    ["<c-b>"] = actions.delete_buffer,
    	    ["<C-x>"] = actions.send_to_qflist + actions.open_qflist,
    	  },
    	  n = {
    	    ["<esc>"] = false,
    	    ["<c-c>"] = actions.close,
    	    ["<C-x>"] = actions.send_to_qflist + actions.open_qflist,
    	    ["<c-b>"] = actions.delete_buffer,
    	  },
    	},
    	vimgrep_arguments = {
    	  'rg',
    	  '--color=never',
    	  '--no-heading',
    	  '--with-filename',
    	  '--line-number',
    	  '--column',
    	  '--smart-case',
    	  '--hidden'
    	},
    	prompt_prefix = "> ",
    	selection_caret = "> ",
    	entry_prefix = "  ",
    	initial_mode = "insert",
    	selection_strategy = "reset",
    	sorting_strategy = "descending",
    	layout_strategy = "horizontal",
    	layout_config = {
    	  horizontal = {
    	    mirror = false,
    	  },
    	  vertical = {
    	    mirror = false,
    	  },
    	},
    	file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    	file_ignore_patterns = {},
    	generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    	winblend = 0,
    	border = {},
    	borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    	color_devicons = true,
    	use_less = true,
    	path_display = {},
    	set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    	file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    	grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    	qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    	-- Developer configurations: Not meant for general override
    	buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
	},
}

if io.popen('uname -m','r'):read('*l') == 'x86_64' then
	require('telescope').load_extension('fzy_native')
end

local M = {}
M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "<< dotfiles >>",
	cwd = "~/",
	hidden = true,
  })
end

return M;
