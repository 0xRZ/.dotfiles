local function dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

local function contains(servers, server)
  for _, value in pairs(servers) do
    if value == server then
      return true
    end
  end
  return false
end

local lsp_status = require('lsp-status')
lsp_status.config({diagnostics = false})
lsp_status.register_progress()
require'lspinstall'.setup() -- important. to make configs of installed servers available for require'lspconfig'.<server>.setup{}
local in_servers = require'lspinstall'.installed_servers()
local nvim_lsp = require'lspconfig'

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  lsp_status.on_attach(client)

  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>ss', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>sd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>xd', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>rm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>rm", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi! link LspReferenceRead MyLspReferenceRead
      hi! link LspReferenceText MyLspReferenceText
      hi! link LspReferenceWrite MyLspReferenceWrite
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end

  vim.api.nvim_set_current_dir(client.config.root_dir);
end

local function setup_servers()

  if in_servers.clangd == nil and vim.fn.executable("clangd") then
    table.insert(in_servers, "cpp")
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }
  capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

  if contains(in_servers, "cpp") then
    nvim_lsp["clangd"].setup {
      handlers = lsp_status.extensions.clangd.setup(),
      --init_options = {
      --  clangdFileStatus = true
      --},
      on_attach = on_attach,
      capabilities = capabilities
    }
  end

  if contains(in_servers, "lua") then
    local sumneko_binary = vim.fn.stdpath('data')..'/lspinstall/lua/sumneko-lua-language-server'
    local config = {
      cmd = { sumneko_binary },
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
            }
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }
	local rtpdirs = vim.api.nvim_get_runtime_file("lua/", true)
    for _, path in pairs(rtpdirs) do
        config.settings.Lua.workspace.library[path] = true
    end
    require'lspconfig'.lua.setup(config)

  end

  if contains(in_servers, "bash") then
    nvim_lsp["bash"].setup {
      on_attach = on_attach,
      capabilities = capabilities
    }
  end

  if contains(in_servers, "vim") then
    nvim_lsp["vim"].setup {
      on_attach = on_attach,
      init_options = {
        isNeovim = true
	  },
      capabilities = capabilities
    }
  end

  if contains(in_servers, "yaml") then
    nvim_lsp["yaml"].setup {
      on_attach = on_attach,
      capabilities = capabilities
    }
  end
end

setup_servers()


----------------
-- completion --

require'compe'.setup {
 enabled = true;
 autocomplete = true;
 debug = false;
 min_length = 1;
 preselect = 'enable';
 throttle_time = 80;
 source_timeout = 200;
 incomplete_delay = 400;
 max_abbr_width = 100;
 max_kind_width = 100;
 max_menu_width = 100;
 documentation = true;

 source = {
   path = true;
   buffer = true;
   calc = true;
   nvim_lsp = true;
   nvim_lua = true;
   ultisnips = true;
 };
}

local t = function(str)
 return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
   local col = vim.fn.col('.') - 1
   if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
       return true
   else
       return false
   end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
 if vim.fn.pumvisible() == 1 then
   return t "<C-n>"
 elseif check_back_space() then
   return t "<Tab>"
 else
   return vim.fn['compe#complete']()
 end
end
_G.s_tab_complete = function()
 if vim.fn.pumvisible() == 1 then
   return t "<C-p>"
 else
   return t "<S-Tab>"
 end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
