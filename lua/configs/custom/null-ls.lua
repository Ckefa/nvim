-- Null-ls configuration for formatting
local null_ls = require("null-ls")

-- Create an autogroup for LSP formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
	sources = {
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.formatting.goimports_reviser,
		null_ls.builtins.formatting.golines,
		null_ls.builtins.formatting.csharpier,
		null_ls.builtins.formatting.prettierd, -- Configure PrettierD
	},
	on_attach = function(client, bufnr)
		-- Enable format on save
		if client.supports_method("textDocument/formatting") then
			-- Clear any existing autocmd for this buffer
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

			-- Format the file before saving
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(client)
							return client.name == "null-ls"
						end,
					})
				end,
			})
		end
	end,
}

return opts
