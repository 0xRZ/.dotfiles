local function dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

-- completions
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  if client.resolved_capabilities.declaration then
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  end
  buf_set_keymap('n', 'gf', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gF', '<Cmd>vsplit<CR><Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  if client.resolved_capabilities.hover then
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  end
  if client.resolved_capabilities.signature_help then
    buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  end
  if client.resolved_capabilities.implementation then
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  end
  buf_set_keymap('n', 'glwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', 'glwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', 'glwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  if client.resolved_capabilities.type_definition then
   buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts) 
  end
  buf_set_keymap('n', 'glr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gla', '<cmd>CodeActionMenu<CR>', opts)
  buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', '<leader>ie', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<leader>F", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- semantic highlight of a variable under cursor
  require 'illuminate'.on_attach(client)
end

-- configure LSPs
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {}

    if server.name == "sumneko_lua" then
		opts = require("lua-dev").setup({
		  library = {
		  		vimruntime = true,
		    	types = true,
		    	plugins = false,
		  },
		  lspconfig = {
		    cmd = {vim.fn.stdpath('data')..'/lsp_servers/sumneko_lua/extension/server/bin/Linux/lua-language-server'},
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
    end

    if server.name == "bashls" or server.name == "yaml" then
		opts = {
			on_attach = on_attach,
   			capabilities = capabilities,
		}
    end

    if server.name == "vimls" then
		opts = {
			on_attach = on_attach,
   			init_options = {
   			  isNeovim = true
  			},
   			capabilities = capabilities,
		}
    end

    if server.name == "diagnosticls" then
		opts = {
			filetypes = { "sh" },
			init_options = {
				linters = {
					shellcheck = {
						command = "shellcheck",
						debounce = 100,
            			args = { "--format=gcc", "-" },
            			offsetLine = 0,
            			offsetColumn = 0,
            			sourceName = "shellcheck",
            			formatLines = 1,
						formatPattern = {
							"^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$",
							{
								line = 1,
								column = 2,
								message = 4,
								security = 3
							}
						},
            			securities = {
            			  error = "error",
            			  warning = "warning",
            			  note = "info"
            			}
					}
				},
				filetypes = {
					sh = "shellcheck",
				},
			},
		}
    end

    server:setup(opts)
end)

local lsp_conf = require'lspconfig'

if vim.fn.executable("clangd") then
    lsp_conf.clangd.setup {
      on_attach = on_attach,
      capabilities = capabilities
    }
end
