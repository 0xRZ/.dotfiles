local gl = require('galaxyline')
local colors = {
  bg = '#2f2d44',
  fg = '#eae8ff',
  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#afd700',
  orange = '#FF8800',
  purple = '#5d4d7a',
  magenta = '#d16d9e',
  grey = '#c0c0c0',
  blue = '#0087d7',
  red = '#ec5f67',
  white = '#ffffff',
}
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree','vista','dbui','packer'}

gls.left[1] = {
  RainbowRed = {
    provider = function() return '▊ ' end,
    highlight = {colors.red,colors.bg}
  },
}
gls.left[2] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {n = colors.red, i = colors.green,v=colors.blue,
                          [''] = colors.blue,V=colors.blue,
                          c = colors.magenta,no = colors.red,s = colors.orange,
                          S=colors.orange,[''] = colors.orange,
                          ic = colors.yellow,R = colors.violet,Rv = colors.violet,
                          cv = colors.red,ce=colors.red, r = colors.cyan,
                          rm = colors.cyan, ['r?'] = colors.cyan,
                          ['!']  = colors.red,t = colors.red}
      if vim.api.nvim_get_option('mod') == 1 then
        vim.api.nvim_command('hi GalaxyViMode guifg='..colors.white)
      else
        vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
      end
      return '綠  '
    end,
    highlight = {colors.red,colors.bg,'bold'},
  },
}
gls.left[3] = {
  WorkDir = {
    provider = function() return vim.fn.getcwd().."/" end,
    condition = condition.buffer_not_empty,
    highlight = {colors.magenta, colors.bg},
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
  }
}
gls.left[4] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
  },
}

gls.left[5] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.magenta,colors.bg,'bold'}
  }
}

gls.left[6] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg},
  },
}

gls.left[7] = {
  PerCent = {
    provider = 'LinePercent',
    separator = '(',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg,'bold'},
  }
}

gls.left[8] = {
  LineCount = {
    provider = function() return vim.fn.line('$') end,
    separator = ')',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg}
  }
}

gls.left[9] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.bg}
  }
}
gls.left[10] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.yellow,colors.bg},
  }
}

gls.left[11] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {colors.cyan,colors.bg},
  }
}

gls.left[12] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.blue,colors.bg},
  }
}

--gls.mid[1] = {
--  ShowLspClient = {
--    provider = 'GetLspClient',
--    condition = function ()
--      local tbl = {['dashboard'] = true,['']=true}
--      if tbl[vim.bo.filetype] then
--        return false
--      end
--      return true
--    end,
--    icon = ' LSP:',
--    highlight = {colors.cyan,colors.bg,'bold'}
--  }
--}

gls.mid[1] = {
   ShowLspInfo = {
    provider = function() return require('lsp-status').status() end,
    highlight = {colors.blue,colors.bg}
  },
}

--gls.right[1] = {
--  FileEncode = {
--    provider = 'FileEncode',
--    condition = condition.hide_in_width,
--    separator = ' ',
--    separator_highlight = {'NONE',colors.bg},
--    highlight = {colors.green,colors.bg,'bold'}
--  }
--}

--gls.right[2] = {
--  FileFormat = {
--    provider = 'FileFormat',
--    condition = condition.hide_in_width,
--    separator = ' ',
--    separator_highlight = {'NONE',colors.bg},
--    highlight = {colors.green,colors.bg,'bold'}
--  }
--}

gls.right[2] = {
  TimeDate = {
    provider = function() return vim.fn.strftime("%d/%m/%y %H:%M") end,
    highlight = {colors.orange,colors.bg}
  }
}

gls.right[3] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.yellow,colors.bg,'bold'},
  }
}

gls.right[4] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.yellow,colors.bg,'bold'},
  }
}

gls.right[5] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = '  ',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.green,colors.bg},
  }
}
gls.right[6] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = ' 柳',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.orange,colors.bg},
  }
}
gls.right[7] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = '  ',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.red,colors.bg},
  }
}

--[[ gls.right[8] = {
   ScrollBar = {
    provider = 'ScrollBar',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg}
  },
} ]]

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg,'bold'}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider =  'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg,'bold'}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {colors.fg,colors.bg}
  }
}
