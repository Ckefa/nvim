-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
        {
                "kylechui/nvim-surround",
                version = "*", -- For stability
                event = "VeryLazy",
                config = function()
                        require("nvim-surround").setup()
                end,
        },
        {
                "williamboman/mason.nvim",
                config = function()
                        require("mason").setup({
                                ensure_installed = {
                                        -- Language servers
                                        "cssls", -- CSS Language Server
                                        "eslint", -- ESLint LSP
                                        "gopls", -- Go Language Server
                                        "html", -- HTML Language Server
                                        "jsonls", -- JSON Language Server
                                        "lua_ls", -- Lua Language Server
                                        "pyright", -- Python Language Server
                                        "pylsp", -- Python LSP Server
                                        "tailwindcss", -- Tailwind CSS Language Server

                                        -- Formatters and linters
                                        "ast-grep", -- AST Grep
                                        "biome", -- Biome (successor to Rome)
                                        "goimports", -- Go Imports Formatter
                                        "golines", -- Go Lines Formatter
                                        "prettier", -- Prettier Formatter
                                        "pylint", -- Python Linter
                                        "pyre", -- Python Type Checker
                                        "quick-lint-js", -- JavaScript Linter
                                        "stylua", -- Lua Formatter
                                },
                        })
                end,
        },
        {
                "williamboman/mason-lspconfig.nvim",
                config = function()
                        require("mason-lspconfig").setup({
                                ensure_installed = {
                                        "cssls",
                                        "eslint",
                                        "gopls",
                                        "html",
                                        "jsonls",
                                        "lua_ls",
                                        "pyright",
                                        "pylsp",
                                        "tailwindcss",
                                },
                        })
                end,
        },
        {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                config = function()
                        require("mason-tool-installer").setup({
                                ensure_installed = {
                                        "ast-grep",
                                        "biome",
                                        "goimports",
                                        "golines",
                                        "prettier",
                                        "pylint",
                                        "pyre",
                                        "quick-lint-js",
                                        "stylua",
                                },
                        })
                end,
        },
}
