function MyDump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
--- folds
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true
}
-- completions
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- buffer lsp conf
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local opts = { noremap=true, silent=true }

	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gf', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'gF', '<Cmd>vsplit<CR><Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', 'glwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', 'glwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', 'glwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', 'gla', '<cmd>CodeActionMenu<CR>', opts)
	buf_set_keymap('n', 'glr', '<cmd>lua require("renamer").rename()<CR>', opts)
	buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
	buf_set_keymap('n', '<leader>ix', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '[x', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']x', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap("n", "glf", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opts)
	buf_set_keymap("x", "glf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)

	-- semantic highlight of a variable under cursor
	require 'illuminate'.on_attach(client)
end

-- diagnostic UI
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.diagnostic.config({
	virtual_text = {
		source = "if_many",
		prefix = '',
		severity = {
		  min = vim.diagnostic.severity.INFO,
		},
		severity_sort = true,
	},
})

local arch = vim.fn.system("uname -m")

local null_ls = require("null-ls")
local null_ls_sources = {}
local treesitter_sources = {}

require("nvim-lsp-installer").setup {
	automatic_installation = { exclude = { "clangd" } }
}

local lsp_conf = require'lspconfig'

-- bash
-- Neoformat: shfmt
table.insert(null_ls_sources, null_ls.builtins.formatting.shellharden)
table.insert(treesitter_sources, "bash")
-- includes shellcheck support
lsp_conf.bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- C/C++
table.insert(null_ls_sources, null_ls.builtins.diagnostics.cppcheck)
table.insert(treesitter_sources, "c")
table.insert(treesitter_sources, "cpp")
if vim.fn.executable("clangd") then
	local clangd_capabilities = {
		textDocument = {
			completion = {
				editsNearCursor = true,
			},
		},
		offsetEncoding = { 'utf-16' },
	}
	capabilities = vim.tbl_deep_extend('keep', capabilities, clangd_capabilities)
	require("clangd_extensions").setup {
		server = {
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = {'clangd', '--header-insertion=never'},
		},
		extensions = {
			autoSetHints = false,
		}
	}
end

-- yaml
-- Neoformat: prettier
table.insert(null_ls_sources, null_ls.builtins.diagnostics.yamllint)
table.insert(treesitter_sources, "yaml")
lsp_conf.yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities
})

-- json
-- Neoformat: prettier
table.insert(treesitter_sources, "json")
table.insert(treesitter_sources, "json5")
table.insert(treesitter_sources, "jsonc")
lsp_conf.jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	json = {
		schemas = require('schemastore').json.schemas(),
		validate = { enable = true },
	},
})

-- vim
table.insert(null_ls_sources, null_ls.builtins.diagnostics.vint)
table.insert(treesitter_sources, "vim")
lsp_conf.vimls.setup({
	on_attach = on_attach,
	capabilities = capabilities
})

-- Dockerfile
table.insert(null_ls_sources, null_ls.builtins.diagnostics.hadolint)
table.insert(treesitter_sources, "dockerfile")
lsp_conf.dockerls.setup({
	on_attach = on_attach,
	capabilities = capabilities
})

-- awk
lsp_conf.awk_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities
})

-- yaml.ansible
-- includes ansiblelint support
if arch == "x86_64\n" then
	lsp_conf.ansiblels.setup({
		settings = {
			ansible = {
				python = {
					interpreterPath = 'python',
				},
				ansibleLint = {
					path = 'ansible-lint',
					enabled = true,
					arguments = "-c " .. vim.env.HOME .. "/.config/ansible-lint.yml",
				},
				ansible = {
					path = 'ansible',
				},
				executionEnvironment = {
					enabled = false,
				},
			},
		},
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- xml
-- Neoformat: prettier
table.insert(null_ls_sources, null_ls.builtins.formatting.xmllint)
lsp_conf.lemminx.setup({
	on_attach = on_attach,
	capabilities = capabilities
})

-- .rst
table.insert(treesitter_sources, "rst")
lsp_conf.esbonio.setup({
	on_attach = on_attach,
	capabilities = capabilities
})

-- nvim lua
if arch == "x86_64\n" then
	lsp_conf.sumneko_lua.setup(require("lua-dev").setup({
		library = {
			vimruntime = true,
			types = true,
			plugins = false,
		},
		lspconfig = {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = {'vim'},
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
				},
			},
		},
	}))
end
table.insert(treesitter_sources, "lua")

-- markdown
-- Neoformat: prettier
table.insert(null_ls_sources, null_ls.builtins.diagnostics.markdownlint.with({
		extra_args = { "--disable", "MD013", "MD010" },
	})
)
table.insert(treesitter_sources, "markdown")

-- .spec (rpm build files)
table.insert(null_ls_sources, null_ls.builtins.diagnostics.rpmspec)

-- zsh
table.insert(null_ls_sources, null_ls.builtins.diagnostics.zsh)

-- Makefile
table.insert(treesitter_sources, "make")

-- cmake
table.insert(treesitter_sources, "cmake")
-- includes cmake_format support
lsp_conf.cmake.setup({
	on_attach = on_attach,
	capabilities = capabilities
})

-- gitcommit
table.insert(null_ls_sources, null_ls.builtins.diagnostics.gitlint)

-- LSP folds
require('ufo').setup()

-- sources for language server within neovim
local on_attach_null_ls = function(_, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local opts = { noremap=true, silent=true }

	buf_set_keymap("n", "<leader>nf", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opts)
    buf_set_keymap("x", "<leader>nf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    buf_set_keymap("n", "<leader>ni", "<cmd>NullLsInfo<CR>", opts)
    buf_set_keymap('n', '<leader>ix', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', '<leader>ix', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '[x', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']x', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

-- all files
table.insert(null_ls_sources, null_ls.builtins.diagnostics.misspell)
table.insert(null_ls_sources, null_ls.builtins.diagnostics.editorconfig_checker.with({
		command = "editorconfig-checker",
		args = {
			"-no-color",
			"-disable-indent-size",
			"$FILENAME",
		},
	})
)

null_ls.setup({
	sources = null_ls_sources,
	on_attach = on_attach_null_ls,
	on_init = function(new_client, _)
		new_client.offset_encoding = 'utf-16'
	end,
	-- :NullLsLog
	-- debug = true,
	-- log = {
	-- 	enable = true,
	-- 	level = "trace",
	-- 	use_console = "sync",
	-- },
})


-- highlights, motion, folds, some info
table.insert(treesitter_sources, "comment")
table.insert(treesitter_sources, "regex")
table.insert(treesitter_sources, "query")
require'nvim-treesitter.configs'.setup {
	ensure_installed = treesitter_sources,
	sync_install = false,
	-- treesitter modules
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
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
