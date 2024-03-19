return {
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' }, -- For luasnip users.
        }, {
            { name = 'buffer' },
        })
      })

      vim.diagnostic.config({
        -- update_in_insert = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
      })
    end
  },
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
  {
    "L3MON4D3/LuaSnip",
    lazy = false,
    dependencies = { "saadparwaiz1/cmp_luasnip" },
    keys = {
      {
        "<leader><leader>;",
        function() require("luasnip").jump(1) end,
        desc = "Jump forward a snippet placement",
        mode = "i",
        noremap = true,
        silent = true
      }, {
        "<leader><leader>,",
        function() require("luasnip").jump(-1) end,
        desc = "Jump backward a snippet placement",
        mode = "i",
        noremap = true,
        silent = true
      }
    },
    config = function()
      require("luasnip.loaders.from_lua").load({ paths = "~/.snippets" })
    end
  }
}
