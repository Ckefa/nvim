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
			timeout = 200, -- Duration of highlight in milliseconds
		})
	end,
})

-- Diagnostics Config
vim.diagnostic.config({
	virtual_text = false, -- Disable inline virtual text
	signs = true, -- Show signs in the sign column
	underline = true, -- Underline the error line
	update_in_insert = false,
	severity_sort = true,
})

-- Floating diagnostics Message on Floating Window
vim.o.updatetime = 250 -- Faster updates for diagnostics

vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	callback = function()
		vim.diagnostic.open_float(nil, { focusable = false })
	end,
})
-- Show diagnostics in the command line when cursor is on an error
-- vim.api.nvim_create_autocmd("CursorHold", {
-- 	pattern = "*",
-- 	callback = function()
-- 		local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
-- 		if #diagnostics > 0 then
-- 			vim.cmd("echohl WarningMsg | echom '" .. diagnostics[1].message .. "' | echohl None")
-- 		end
-- 	end,
-- })

-- Copy Diagnostics to Clipboard
vim.api.nvim_create_user_command("CopyDiagnostic", function()
	local pos = vim.api.nvim_win_get_cursor(0)
	local line, col = pos[1] - 1, pos[2] -- Get cursor position (0-based line)

	local diagnostics = vim.diagnostic.get(0, { lnum = line }) -- Get all diagnostics on this line
	for _, diag in ipairs(diagnostics) do
		if col >= diag.col and col < diag.end_col then -- Check if cursor is inside this diagnostic
			vim.fn.setreg("+", diag.message) -- Copy to clipboard
			print("Copied Diagnostic: " .. diag.message)
			return
		end
	end
	print("No diagnostic found under cursor")
end, {})
-- Copy Diagnostics keymap
vim.keymap.set("n", "<leader>cd", "<cmd>CopyDiagnostic<CR>", { desc = "Copy diagnostic under cursor" })

-- Bootstrap lazy.nvim and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)
vim.opt.relativenumber = true

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
