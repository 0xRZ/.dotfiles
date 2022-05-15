local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')

require('telescope').setup{
    defaults = {
		mappings = {
		  i = {
			["<C-w>"] = { "<esc>ciw",type = "command" },
			["<C-j>"] = actions.move_selection_next,
			["<C-p>"] = action_layout.toggle_preview,
			["<C-k>"] = actions.move_selection_previous,
			["<C-b>"] = actions.delete_buffer,
			["<C-x>"] = actions.select_horizontal,
			["<C-s>"] = actions.select_vertical,
			["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
			["<C-h>"] = require("telescope").extensions.hop.hop,  -- hop.hop_toggle_selection
		  },
		  n = {
			["<C-w>"] = { "<esc>", type = "command" },
			["<esc>"] = false,
			["<C-p>"] = action_layout.toggle_preview,
			["<C-b>"] = actions.delete_buffer,
			["<C-x>"] = actions.select_horizontal,
			["<C-s>"] = actions.select_vertical,
			["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
			["<C-c>"] = actions.close,
			["<C-h>"] = require("telescope").extensions.hop.hop,  -- hop.hop_toggle_selection
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
		border = false,
		layout_strategy = "bottom_pane",
		layout_config = {
			bottom_pane = {
				height = 30,
				prompt_position = "top"
			},
		},
		prompt_prefix = "  ",
		selection_caret = "",
		entry_prefix = "",
	},

    pickers = {
		find_files = {
			hidden = true,
			no_ignore = true,
		},
		help_tags = {
			mappings = {
				i = {
					["<CR>"] = actions.select_vertical,
				},
				n = {
					["<CR>"] = actions.select_vertical,
				},
			},
		},
		man_pages = {
			sections = { "ALL" },
			mappings = {
				i = {
					["<CR>"] = actions.select_vertical,
				},
				n = {
					["<CR>"] = actions.select_vertical,
				},
			},
		},
    },

	extensions = {
        heading = {
            treesitter = true,
        },

		command_palette = {
			{
				"File",
				{ "entire selection (C-a)", ':call feedkeys("GVgg")' },
			},
			{
				"Vim",
				{ "open vimrc", ":vsplit $MYVIMRC" },
				{ "reload vimrc", ":source $MYVIMRC" },
				{ 'check health', ":checkhealth" },
			},
			{
				"Git",
				{ "show history since parent commit", ':call MyFuncShowBranchCommitDiffs()' },
				{ "show diff since parent commit", ':call MyFuncShowBranchDiffs()' },
			},
			{
				"Plugins",
				{ "refresh (clean/install) plugins", ":source $MYVIMRC | PlugClean | PlugInstall" },
				{ "update plugins", ":PlugUpdate --sync | TSUpdate" },
			},
		},

		hop = {
			sign_hl = { "WarningMsg", "WarningMsg" },
		},
	}
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('projects')
require('telescope').load_extension('heading')
require('telescope').load_extension('command_palette')
require('telescope').load_extension('env')
require('telescope').load_extension('hop')
