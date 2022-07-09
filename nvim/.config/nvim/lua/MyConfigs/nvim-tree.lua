local tree_cb = require'nvim-tree.config'.nvim_tree_callback

local list_binds = {
    { key = "<C-s>",                        cb = tree_cb("vsplit") },
    { key = "<C-[>",                        cb = tree_cb("dir_up") },
    { key = "s",                            cb = "<cmd>HopLine<CR>" },
    { key = "<C-e>",                        cb = "<C-e>" },
}

require'nvim-tree'.setup {
    view = {
        width = 40,
        mappings = {
	    list = list_binds,
	},
    },
    filters = {
		dotfiles = false,
		custom = {
		    'node_modules',
		    '.cache',
		    '*.o',
		}
    },
    update_cwd = true,
    update_focused_file = {
		enable = true,
		update_cwd = true,
    },
    trash = {
	cmd = "trash",
		require_confirm = true,
    },
	actions = {
		open_file = {
			quit_on_open = true,
		},
	}
}
