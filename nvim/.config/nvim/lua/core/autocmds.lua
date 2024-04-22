local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars", "*.tftest.hcl"},
  callback = function()
    vim.lsp.buf.format()
  end,
})
