local opts = {
    -- Custom LSPs
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "ts_ls",                       -- typescript LSP
        "tailwindcss-language-server", -- Tailwind LSP
        "eslint-lsp",                  -- Javascript Linter nad Lsp
        "prettierd",                   -- Text Formatter
      }
    }
  },

-- Custom Lsp configs
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.custom.lspconfig"
    end,
  },

  -- None Ls Plugin
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = {
      getnull = function()
        require "configs.custom.null-ls"
      end,
    }
  },

  -- Auto Close tags 
  {
    "windwp/nvim-ts-autotag",
    ft = {"Javascript", "typescript", "html"},
    config = function()
      require = ("nvim-ts-autotag").setup()
    end,
  },

  -- Nvim treesitter for languages 
  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css", "python", "javascript", "typescript", "go",
  		},
  	},
  },

  -- Comment Highlighte Selection
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
