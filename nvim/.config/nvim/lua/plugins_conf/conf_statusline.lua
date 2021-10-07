-- current LSP symbols under cursor
local gps = require("nvim-gps")
gps.setup()

local mycode = {}
local colors = {
  black        = "#262626",
  white        = '#ffffff',
  red          = '#f44747',
  green        = '#619955',
  blue         = '#A89EFF',
  lightblue    = '#5CB6F8',
  yellow       = '#ffaf00',
}
mycode.normal = {
  b = {fg = colors.blue, bg = colors.black},
  a = {fg = colors.white, bg = colors.blue, gui = 'bold'},
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
  a = {fg = colors.black, bg = colors.yellow, gui = 'bold'},
  b = {fg = colors.yellow, bg = colors.black},
  c = {fg = colors.white, bg = colors.black}
}
local function trailing_ws()
  return vim.fn.search([[\s\+$]], 'nw') ~= 0 and 'TW' or ''
end
require'lualine'.setup {
  options = {
    theme = mycode,
    section_separators = '',
    component_separators = '',
	disabled_filetypes = {'help', 'man', 'Outline', 'GV'},
  },
  sections = {
    lualine_a = {
		{ 'mode', separator = { left = '' }, right_padding = 2 },
    },
	lualine_b = {
		'branch',
		{
			'diff',
    	    colored = true,
    	    diff_color = {
    	    	added = { fg = '#00FF5E', },
    	    	modified = { fg = '#FFD500', },
    	    	removed = { fg = '#FF0000', },
    	    },
		},
	},
	lualine_c = {'filename', 'lsp_progress',
				trailing_ws, {
					gps.get_location,
					cond = gps.is_available,
				}, 'grepper#statusline'},
    lualine_x = {
	{
		'diagnostics',
		sources = {'nvim_lsp'},
    	diagnostics_color = {
    		error = { fg = '#FF0000', },
    		warn  = { fg = '#FFEF00', },
    		info  = { fg = '#9FC3FF', },
    		hint  = { fg = '#97FFFF', },
    	},
	},
	'encoding', 'filetype' },
    lualine_y = {'progress'},
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  extensions = {'quickfix', 'nvim-tree', 'fugitive'}
}
