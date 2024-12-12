
local opts = {
  -- Mason for managing tools
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP servers
        "typescript-language-server",  -- TypeScript LSP
        "tailwindcss-language-server", -- Tailwind LSP
        "eslint-lsp",                  -- ESLint LSP
        "pyright",                     -- Python LSP
        "gopls",                       -- Go LSP
        "html-lsp",                    -- HTML LSP
        "json-lsp",                    -- JSON LSP
        "lua-language-server",         -- Lua LSP

        -- Formatters
        "prettierd",                   -- Prettier Formatter
        "stylua",                      -- Lua Formatter
        "goimports",                   -- Go Imports Formatter
        "golines",                     -- Go Lines Formatter

        -- Linters
        "pylint",                      -- Python Linter
        "quick-lint-js",               -- JavaScript Linter
        "biome",                       -- Biome Formatter and Linter

        -- Type Checkers
        "pyre",                        -- Python Type Checker

        -- Tools
        "ast-grep",                    -- AST Grep Tool
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)

      -- Automatically install all packages in ensure_installed
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },

  -- Custom LSP configurations
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.custom.lspconfig"
    end,
  },

  -- null-ls for additional code actions and formatting
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = {
      getnull = function()
        require "configs.custom.null-ls"
      end,
    },
  },

  -- Auto close tags
  {
    "windwp/nvim-ts-autotag",
    config = true, -- Automatically calls setup if the plugin supports it
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  -- Treesitter for language parsing
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "python", "javascript", "typescript", "go",
        "jsx", "tsx",
      },
      highlight = { enable = true },
      autotag = { enable = true },
    },
  },

  -- Surround text management
  {
    "kylechui/nvim-surround",
    version = "*", -- For stability
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
}

return opts

