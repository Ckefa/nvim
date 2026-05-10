local nvlsp = require("nvchad.configs.lspconfig")

-- List of LSP servers to setup
local servers = {
	"ts_ls", -- TypeScript
	"pylsp", -- Python
	"gopls", -- Go
	"html", -- HTML
	"jsonls", -- JSON
	"lua_ls", -- Lua
	"csharp_ls", -- C#
}

for _, lsp in ipairs(servers) do
	local settings = {}

	-- Add server-specific settings
	if lsp == "ts_ls" then
		settings = {
			documentFormatting = false, -- Example setting
		}
	elseif lsp == "gopls" then
		settings = {
			gopls = {
				completeUnimported = true,
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
			},
		}
	end

	vim.lsp.config(lsp, {
		on_attach = nvlsp.on_attach,
		on_init = nvlsp.on_init,
		capabilities = nvlsp.capabilities,
		settings = settings,
	})
	vim.lsp.enable(lsp)
end
