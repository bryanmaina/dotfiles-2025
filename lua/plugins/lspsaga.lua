return {
	"nvimdev/lspsaga.nvim",
	-- ft = { "rust" },
	cmd = "Lspsaga",
	config = function()
		require("lspsaga").setup({
			request_timeout = 5000,
			diagnostic = {
				show_layout = "normal",
				show_normal_height = 0.5,
				extend_relatedInformation = true,
				keys = {
					exec_action = "o",
					quit = "q",
					toggle_or_jump = "<cr>",
					quit_in_show = { "q", "<esc>" },
				},
			},
			definition = {
				keys = {
					edit = "<C-c>o",
					vsplit = "<C-c>v",
					split = "<C-c>s",
					tabe = "<C-c>t",
					quit = "q",
					close = "<C-c>k",
				},
			},
			finder = {
				max_height = 0.4,
				left_width = 0.3,
				default = "def+ref+imp",
				layout = "normal",
				keys = {
					toggle_or_open = "o",
					vsplit = "v",
					split = "s",
					quit = "q",
					close = "<c-c>k",
				},
			},
			implement = {
				enable = false,
			},
			lightbulb = {
				enable = false,
			},
			outline = {
				win_width = 60,
				win_position = "right",
				auto_preview = false,
				auto_close = true,
				layout = "normal",
				keys = {
					toggle_or_jump = "<cr>",
					quit = "q",
				},
			},
			rename = {
				auto_save = true,
			},
			symbol_in_winbar = {
				enable = false,
			},
			ui = {
				title = false,
			},
		})
	end,
	keys = {
		{ "<leader>a", desc = "[C]ode [A]ction", "<cmd>Lspsaga code_action<CR>", mode = { "n" } },
		{ "<leader>o", desc = "Toogle [O]utline", "<cmd>Lspsaga outline<CR>", mode = { "n" } },
		-- { "<leader>rn", desc = "[R]e[n]ame", "<cmd>Lspsaga rename<CR>", mode = { "n" } },
		{ "gp", desc = "[P]eek Definition", "<cmd>Lspsaga peek_definition<CR>", mode = { "n" } },
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
}
