return {
	"nickjvandyke/opencode.nvim",
	lazy = false,
	version = "*",
	dependencies = {
		{ "folke/snacks.nvim", optional = true, opts = { input = {}, picker = {}, terminal = {} } },
	},
	config = function()
		vim.g.opencode_opts = {
			server = {
				port = nil,
			},
		}

		vim.o.autoread = true

		vim.keymap.set({ "n", "t" }, "<leader>oo", function()
			require("opencode").toggle()
		end, { desc = "Toggle opencode" })

		vim.keymap.set({ "n", "x" }, "<leader>oa", function()
			require("opencode").ask("@this: ", { submit = true })
		end, { desc = "Ask opencode" })

		vim.keymap.set({ "n", "x" }, "<leader>os", function()
			require("opencode").select()
		end, { desc = "Execute opencode action" })

		vim.keymap.set({ "n", "x" }, "<leader>or", function()
			return require("opencode").operator("@this ")
		end, { expr = true, desc = "Add range to opencode" })
	end,
}
