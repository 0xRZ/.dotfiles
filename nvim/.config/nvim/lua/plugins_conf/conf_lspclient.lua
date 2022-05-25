function MyDump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

-- completions
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  if client.server_capabilities.declaration then
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  end
  buf_set_keymap('n', 'gf', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gF', '<Cmd>vsplit<CR><Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  if client.server_capabilities.hover then
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  end
  if client.server_capabilities.signature_help then
    buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  end
  if client.server_capabilities.implementation then
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  end
  buf_set_keymap('n', 'glwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', 'glwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', 'glwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  if client.server_capabilities.type_definition then
   buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  end
  -- buf_set_keymap('n', 'glr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gla', '<cmd>CodeActionMenu<CR>', opts)
  buf_set_keymap('n', 'glr', '<cmd>lua require("renamer").rename()<CR>', opts)
  buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', '<leader>ix', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[x', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']x', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  if client.server_capabilities.document_formatting then
    buf_set_keymap("n", "glf", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opts)
  end
  if client.server_capabilities.document_range_formatting then
    buf_set_keymap("v", "glf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- semantic highlight of a variable under cursor
  require 'illuminate'.on_attach(client)
end

local lsp_servers = {}
lsp_servers["sumneko_lua"] = function()
	local opt
	opt = require("lua-dev").setup({
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
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
			},
		},
	},
	})
	return opt
end
lsp_servers["bashls"] = function()
	local opt
	opt = {
		on_attach = on_attach,
		capabilities = capabilities,
	}
	return opt
end
lsp_servers["yaml"] = lsp_servers["bashls"]
lsp_servers["vimls"] = function()
	local opt
	opt = {
		on_attach = on_attach,
		init_options = {
		  isNeovim = true
		},
		capabilities = capabilities,
	}
	return opt
end
-- lsp_servers["diagnosticls"] = function()
-- 	local opt
-- 	opt = {
-- 		filetypes = { "sh" },
-- 		init_options = {
-- 			linters = {
-- 				shellcheck = {
-- 					command = "shellcheck",
-- 					debounce = 100,
-- 					args = { "--format=gcc", "-" },
-- 					offsetLine = 0,
-- 					offsetColumn = 0,
-- 					sourceName = "shellcheck",
-- 					formatLines = 1,
-- 					formatPattern = {
-- 						"^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$",
-- 						{
-- 							line = 1,
-- 							column = 2,
-- 							message = 4,
-- 							security = 3
-- 						}
-- 					},
-- 					securities = {
-- 					  error = "error",
-- 					  warning = "warning",
-- 					  note = "info"
-- 					}
-- 				}
-- 			},
-- 			filetypes = {
-- 				sh = "shellcheck",
-- 			},
-- 		},
-- 	}
-- 	return opt
-- end

local lsp_installer_servers = require'nvim-lsp-installer.servers'

-- for n, f in pairs(lsp_servers) do
-- 	local server_available, requested_server = lsp_installer_servers.get_server(n)
-- 	if server_available then
-- 		requested_server:on_ready(function ()
-- 			local opts = f()
-- 			requested_server:setup(opts)
-- 		end)
-- 		if not requested_server:is_installed() then
-- 			requested_server:install()
-- 		end
-- 	end
-- end

-- UI
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
-- UI

require("nvim-lsp-installer").setup {
	automatic_installation = false,
	ensure_installed = { "bashls", "yamlls", "prosemd_lsp", "jsonls", "vimls", "grammarly", "dockerls", "awk_ls", "ansiblels", "lemminx", "esbonio", "sumneko_lua" },
}
local lsp_conf = require'lspconfig'

-- C/C++
if vim.fn.executable("clangd") then
	local clangd_capabilities = {
		textDocument = {
			completion = {
				editsNearCursor = true,
			},
		},
		offsetEncoding = { 'utf-16' },
	}
	capabilities = vim.tbl_extend('keep', capabilities, clangd_capabilities)
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
	-- lsp_conf.clangd.setup {
	-- 	on_attach = on_attach,
	-- 	capabilities = capabilities,
	-- 	cmd = {'clangd', '--header-insertion=never'},
	-- }
end
-- C/C++

-- bash
lsp_conf.bashls.setup {
	on_attach = on_attach,
	capabilities = capabilities
}
-- bash

-- YAML
lsp_conf.yamlls.setup {
	on_attach = on_attach,
	capabilities = capabilities
}
-- YAML

-- -- Markdown
-- lsp_conf.prosemd_lsp.setup {
-- 	on_attach = on_attach,
-- 	capabilities = capabilities
-- }
-- -- Markdown

-- json
lsp_conf.jsonls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	json = {
		schemas = require('schemastore').json.schemas(),
		validate = { enable = true },
	},
}
-- json

-- vimscript
lsp_conf.vimls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- vimscript

-- lsp_conf.grammarly.setup {
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- }

-- Dockerfile
lsp_conf.dockerls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- Dockerfile

-- awk
lsp_conf.awk_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- awk

-- yaml.ansible
lsp_conf.ansiblels.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- yaml.ansible

-- xml
lsp_conf.lemminx.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- xml

-- .rst
lsp_conf.esbonio.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- .rst

-- lsp_conf.diagnosticls.setup {
-- 	filetypes = { "sh" },
-- 	init_options = {
-- 		linters = {
-- 			shellcheck = {
-- 				command = "shellcheck",
-- 				debounce = 100,
-- 				args = { "--format=gcc", "-" },
-- 				offsetLine = 0,
-- 				offsetColumn = 0,
-- 				sourceName = "shellcheck",
-- 				formatLines = 1,
-- 				formatPattern = {
-- 					"^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$",
-- 					{
-- 						line = 1,
-- 						column = 2,
-- 						message = 4,
-- 						security = 3
-- 					}
-- 				},
-- 				securities = {
-- 				  error = "error",
-- 				  warning = "warning",
-- 				  note = "info"
-- 				}
-- 			}
-- 		},
-- 		filetypes = {
-- 			sh = "shellcheck",
-- 		},
-- 	},
-- }

-- nvim lua
local luadev = require("lua-dev").setup({
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
})
lsp_conf.sumneko_lua.setup(luadev)
-- nvim lua

-- sources for language server within neovim
local on_attach_null_ls = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local opts = { noremap=true, silent=true }

	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap("n", "<leader>nf", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opts)
    buf_set_keymap("v", "<leader>nf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    buf_set_keymap('n', '<leader>ix', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
end

local null_ls = require("null-ls")

local sources = {
	-- bash
	null_ls.builtins.formatting.shellharden,
	-- c/c++
	null_ls.builtins.diagnostics.cppcheck,
	-- -- markdown
	-- null_ls.builtins.diagnostics.markdownlint.with({
	-- 	extra_args = { "--disable MD013" }
	-- }),
	-- Dockerfile
	null_ls.builtins.diagnostics.hadolint,
	-- .spec (rpm build files)
	null_ls.builtins.diagnostics.rpmspec,
	-- vimscript
	null_ls.builtins.diagnostics.vint,
	-- -- markdown, json, yaml
	-- null_ls.builtins.formatting.prettier,
	-- zsh
	null_ls.builtins.diagnostics.zsh,
	-- xml
	null_ls.builtins.formatting.xmllint,
	null_ls.builtins.diagnostics.gitlint,
	-- null_ls.builtins.diagnostics.misspell,
	-- null_ls.builtins.diagnostics.editorconfig_checker.with({
        -- command = "editorconfig-checker",
	-- 	filetypes = { "sh", "c", "cpp", "lua", "vim" },
    -- }),
	-- null_ls.builtins.hover.dictionary.with({
	-- 	filetypes = { "text", "gitcommit", "markdown" },
    -- }),
}

null_ls.setup({
    sources = sources,
    on_attach = on_attach_null_ls,
    on_init = function(new_client, _)
      new_client.offset_encoding = 'utf-16'
    end,
})

-- sources for language server within neovim
