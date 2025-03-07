return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{ "reasonml-editor/tree-sitter-reason" },
	},
	build = ":TSUpdate",
	branch = "main",
	lazy = false,
	opts = {
		ensure_install = {
			"core",
			"stable",
			-- Elixir langs
			"elixir",
			"lua",
			"heex",
		},
	},
}
