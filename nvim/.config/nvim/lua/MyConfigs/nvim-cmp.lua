local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require('cmp')
-- icons for completion menu items
local lspkind = require('lspkind')

cmp.setup{
  formatting = {
    format = lspkind.cmp_format({with_text = true, maxwidth = 50})
  },
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sorting = {
    comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.recently_used,
        require("clangd_extensions.cmp_scores"),
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
    },
  },
  mapping = {
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ["<C-j>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif vim.fn["vsnip#jumpable"](1) == 1 then
			feedkey("<Plug>(vsnip-jump-next)", "")
		end
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif vim.fn["vsnip#jumpable"](-1) == 1 then
			feedkey("<Plug>(vsnip-jump-prev)", "")
		end
    end, { "i", "s" }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.close(),
      c = cmp.mapping.close(),
    }),
    ['<C-x>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.abort(),
    }),
	['<C-l>'] = cmp.mapping({
		i = cmp.mapping.confirm({ select = false }),
		c = function(fallback)
			if cmp.visible() then
				cmp.confirm({ select = false })
			else
				fallback()
			end
		end
	}),
  },
  sources = {
    { name = 'vsnip' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }
}

cmp.setup.cmdline('/', {
	mapping = {
		['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
		['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
	},
	sources = { { name = 'buffer' } } }
)

cmp.setup.cmdline(':', {
	mapping = {
		['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
		['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
	},
	sources = { { name = 'cmdline' } }
})

cmp.setup.cmdline('@', {
	mapping = {
		['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
		['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
	},
	sources = { { name = 'path' } }
})
