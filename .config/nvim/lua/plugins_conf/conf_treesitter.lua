require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
--    custom_captures = {
--      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
--      ["foo.bar"] = "Identifier",
--    },
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
}

vim.api.nvim_win_set_option(0,"foldmethod","expr")
vim.api.nvim_win_set_option(0,"foldexpr","nvim_treesitter#foldexpr()")
vim.api.nvim_win_set_option(0,"foldlevel",99)
