lua << EOF
vim.diagnostic.config({
  virtual_text = {
    source = "if_many",
	prefix = '',
	severity = {
      min = vim.diagnostic.severity.INFO,
    },
  },
})
EOF
