require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
--    custom_captures = {
--      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
--      ["foo.bar"] = "Identifier",
--    },
	additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
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
        ["]m"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]i"] = "@conditional.outer",
        ["]l"] = "@loop.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]I"] = "@conditional.outer",
        ["]L"] = "@loop.outer",
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

vim.api.nvim_win_set_option(0,"foldmethod","expr")
vim.api.nvim_win_set_option(0,"foldexpr","nvim_treesitter#foldexpr()")
vim.api.nvim_win_set_option(0,"foldlevel",99)
