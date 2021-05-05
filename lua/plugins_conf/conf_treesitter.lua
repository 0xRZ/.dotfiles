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
  }
}

vim.api.nvim_win_set_option(0,"foldmethod","expr")
vim.api.nvim_win_set_option(0,"foldexpr","nvim_treesitter#foldexpr()")
vim.api.nvim_win_set_option(0,"foldlevel",99)
