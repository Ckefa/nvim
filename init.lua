vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "

-- Clipboard configuration for win32yank
-- vim.g.clipboard = {
--   name = "win32yank",
--   copy = {
--     ["+"] = "win32yank -i --crlf",
--     ["*"] = "win32yank -i --crlf",
--   },
--   paste = {
--     ["+"] = "win32yank -o --lf",
--     ["*"] = "win32yank -o --lf",
--   },
--   cache_enabled = 0,
-- }

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", {}),
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch", -- Highlight group to use
      timeout = 200,         -- Duration of highlight in milliseconds
    })
  end,
})

-- Bootstrap lazy.nvim and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

-- Load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
  { import = "plugins.custom" },
}, lazy_config)

-- Load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("options")
require("nvchad.autocmds")

vim.schedule(function()
  require("mappings")
end)
