return {
	"nvimdev/lspsaga.nvim",
	-- ft = { "rust" },
	cmd = "Lspsaga",
	config = function()
		require("lspsaga").setup({
			finder_action_keys = { open = "<CR>" },
			definition_action_keys = { edit = "<CR>" },
			lightbulb = {
				sign = false,
			},
		})
	end,
	keys = {
		{ "<leader>a", desc = "[C]ode [A]ction", "<cmd>Lspsaga code_action<CR>", mode = { "n" } },
		{ "<leader>o", desc = "Toogle [O]utline", "<cmd>Lspsaga outline<CR>", mode = { "n" } },
		{ "<leader>gp", desc = "[P]eek Definition", "<cmd>Lspsaga peek_definition<CR>", mode = { "n" } },
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
}
