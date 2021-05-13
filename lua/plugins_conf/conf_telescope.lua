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
      },
      n = {
        ["<esc>"] = false,
        ["<c-c>"] = actions.close,
      },
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "bottom",
    prompt_prefix = ">>>> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

require('telescope').load_extension('fzy_native')

local M = {}
M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "<< dotfiles >>",
	cwd = "~/.config/",
  })
end

return M;
