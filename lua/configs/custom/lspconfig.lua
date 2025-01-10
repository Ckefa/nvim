local lspconfig = require("lspconfig")
local nvlsp = require("nvchad.configs.lspconfig")

-- List of LSP servers to setup
local servers = {
	"ts_ls", -- TypeScript
	"tailwindcss", -- Tailwind CSS
	"eslint", -- ESLint
	"pylsp", -- Python
	"gopls", -- Go
	"html", -- HTML
	"jsonls", -- JSON
	"lua_ls", -- Lua
}

for _, lsp in ipairs(servers) do
	local settings = {}

	-- Add server-specific settings
	if lsp == "tsserver" then
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

	lspconfig[lsp].setup({
		on_attach = nvlsp.on_attach,
		on_init = nvlsp.on_init,
		capabilities = nvlsp.capabilities,
		settings = settings,
	})
end
