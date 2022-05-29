-- current LSP symbols under cursor
local gps = require("nvim-gps")
gps.setup()

local mycode = {}
local colors = {
	black		= "#262626",
	lighblack	= "#653333",
	white		= '#ffffff',
	red		= '#FF0000',
	lightred	= '#FFD1D1',
	lightblue	= '#5CB6F8',
	yellow		= '#ffaf00',
}
mycode.normal = {
	a = {fg = colors.white, bg = colors.red, gui = 'bold'},
	b = {fg = colors.white, bg = colors.lighblack},
	c = {fg = colors.white, bg = colors.black},
}
mycode.visual = {
	a = {fg = colors.black, bg = colors.lightblue, gui = 'bold'},
	b = {fg = colors.lightblue, bg = colors.black},
}
mycode.inactive = {
	b = {fg = colors.white, bg = colors.black, gui = 'bold'},
	a = {fg = colors.white, bg = colors.black, gui = 'bold'},
	c = {fg = colors.white, bg = colors.black, gui = 'bold'},
}
mycode.replace = {
	b = {fg = colors.yellow, bg = colors.black},
	a = {fg = colors.black, bg = colors.yellow, gui = 'bold'},
	c = {fg = colors.white, bg = colors.black}
}
mycode.insert = {
	a = {fg = colors.black, bg = colors.lightred, gui = 'bold'},
	b = {fg = colors.lightred, bg = colors.black},
	c = {fg = colors.white, bg = colors.black}
}

local function trailing_ws()
	return vim.fn.search([[\s\+$]], 'nw') ~= 0 and 'TW' or ''
end
require'lualine'.setup {
	options = {
		theme = mycode,
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {'GV'},
		globalstatus = true,
	},
	sections = {
		lualine_a = {
			{
				gps.get_location,
				cond = gps.is_available,
			},
		},

		lualine_b = {
			{
				'branch',
			},
			{
				'diff',
				colored = true,
				diff_color = {
					added = { fg = '#00FF5E', },
					modified = { fg = '#FFD500', },
					removed = { fg = '#FF0000', },
				},
				separator = { right = '' }
			},
		},

		lualine_c = {
			'filename',
			trailing_ws,
			'lsp_progress',
			'grepper#statusline',
		},

		lualine_x = {
			{
				'filetype',
				separator = '',
			},
			{
				separator = '',
				'diagnostics',
				sources = {'nvim_diagnostic'},
				diagnostics_color = {
					error = { fg = '#FF0000', },
					warn  = { fg = '#FFEF00', },
					info  = { fg = '#9FC3FF', },
					hint  = { fg = '#97FFFF', },
				},
			},
			{
				'tabs',
				separator = '',
				mode = 1,
				tabs_color = {
					active = { fg = colors.red, bg = colors.black },
					inactive = { fg = colors.white, bg = colors.black },
				},
			},
		},

		lualine_y = {
			{
				'location',
				separator = { left = '' },
			}
		},

		lualine_z = {
			{
				'progress',
				separator = { left = '' },
			}
		},
	},

	extensions = {'quickfix', 'nvim-tree', 'fugitive', 'symbols-outline'},
}
