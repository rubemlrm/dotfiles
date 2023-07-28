return {
  {
    -- NULL-LS
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        debug = true,
        sources = {
          null_ls.builtins.code_actions.shellcheck,             -- https://www.shellcheck.net/
          null_ls.builtins.diagnostics.checkmake,               -- https://github.com/mrtazz/checkmake
          null_ls.builtins.diagnostics.golangci_lint,           -- https://github.com/golangci/golangci-lint (~/.golangci.yml)
          null_ls.builtins.diagnostics.staticcheck,           -- https://github.com/dominikh/go-tools
          null_ls.builtins.diagnostics.write_good,            -- https://github.com/btford/write-good
          null_ls.builtins.diagnostics.zsh,                   -- https://www.zsh.org/ (uses zsh command's -n option to evaluate code, not execute it)
          null_ls.builtins.formatting.black,                  -- https://github.com/psf/black
          null_ls.builtins.formatting.autopep8,               -- https://github.com/hhatto/autopep8
          null_ls.builtins.formatting.fixjson,                     -- https://github.com/rhysd/fixjson
          null_ls.builtins.formatting.goimports_reviser,           -- https://pkg.go.dev/github.com/incu6us/goimports-reviser
          null_ls.builtins.formatting.isort,                       -- https://github.com/PyCQA/isort
          null_ls.builtins.formatting.lua_format,                  -- https://github.com/Koihik/LuaFormatter
          null_ls.builtins.formatting.markdown_toc,                -- https://github.com/jonschlinkert/markdown-toc
          null_ls.builtins.formatting.mdformat,                    -- https://github.com/executablebooks/mdformat
          null_ls.builtins.formatting.ocdc,                        -- https://github.com/mdwint/ocdc
          null_ls.builtins.formatting.shfmt,                       -- https://github.com/mvdan/sh
          null_ls.builtins.formatting.yamlfmt                      -- https://github.com/google/yamlfmt
        }
      })
    end
  }
}