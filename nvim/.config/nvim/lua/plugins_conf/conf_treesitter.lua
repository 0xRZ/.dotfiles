require'nvim-treesitter.configs'.setup {

  ensure_installed = { "c", "cpp", "lua", "bash", "vim", "yaml", "query", "markdown", "rst" },
  sync_install = false,
  -- treesitter modules
  highlight = {
    enable = true,
	additional_vim_regex_highlighting = false,
  },

  -- JoosepAlviste/nvim-ts-context-commentstring plugin
  -- semantic nested commenting
  context_commentstring = {
    enable = true
  },

  -- andymass/vim-matchup plugin
  -- better integration for %
  matchup = {
    enable = true,
  },

  -- p00f/nvim-ts-rainbow plugin
  -- highlight parentheses
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
	colors = {
	  "#000000",
	  "#003CFF",
	  "#D27000",
	  "#00D207",
	  "#CD007B",
	  "#9A00FF",
	  "#00C4DA",
    },
  },

  -- nvim-treesitter/playground plugin
  playground = {},

  -- nvim-treesitter-textobjects plugin
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ak"] = "@comment.outer",
        ["ii"] = "@conditional.inner",
        ["ai"] = "@conditional.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]M"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]I"] = "@conditional.outer",
        ["]L"] = "@loop.outer",
      },
      goto_next_end = {
        ["]m"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]i"] = "@conditional.outer",
        ["]l"] = "@loop.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
		["[c"] = "@class.outer",
        ["[i"] = "@conditional.outer",
        ["[l"] = "@loop.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[C"] = "@class.outer",
        ["[I"] = "@conditional.outer",
        ["[L"] = "@loop.outer",
      },
    },
  },

}
