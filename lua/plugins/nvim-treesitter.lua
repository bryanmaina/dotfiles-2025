return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	keys = {
		{ "<c-space>", desc = "Increment Selection" },
		{ "<bs>", desc = "Decrement Selection", mode = "x" },
	},
	opts = function(_, opts)
		if type(opts.ensure_installed) == "table" then
			vim.list_extend(opts.ensure_installed, { "angular", "scss" })
		end
		vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
			pattern = { "*.component.html", "*.container.html" },
			callback = function()
				vim.treesitter.start(nil, "angular")
			end,
		})
		require("nvim-treesitter.configs").setup({
			modules = {},
			sync_install = false,
			ignore_install = {},
			auto_install = true,
			autotag = {
				enable = true,
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			ensure_installed = {
				"angular",
				"bash",
				"comment",
				"css",
				"diff",
				"dockerfile",
				"fish",
				"git_config",
				"git_rebase",
				"gitcommit",
				"gitignore",
				"html",
				"java",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"scss",
				"toml",
				"tsx",
				"vim",
				"vimdoc",
				"yaml",
			},
		})
	end,
}
