return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<leader>cf",
			desc = "Format current file",
			function()
				require("conform").format({
					lsp_fallback = false,
					async = false,
					timeout_ms = 1000,
				})
			end,
			mode = { "n", "v" },
		},
	},
	opts = {
		formatters_by_ft = {
			astro = { "prettierd" },
			bash = { "beautysh" },
			css = { "prettierd" },
			erb = { "htmlbeautifier" },
			graphql = { "prettierd" },
			go = { "gofmt" },
			html = { "htmlbeautifier" },
			java = { "google-java-format" },
			kotlin = { "ktlint" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			json = { "prettierd" },
			lua = { "stylua" },
			markdown = { "prettierd" },
			proto = { "buf" },
			ruby = { "standardrb" },
			rust = { "leptosfmt" },
			scss = { "prettierd" },
			sh = { "shellcheck" },
			svelte = { "prettierd" },
			toml = { "taplo" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			xml = { "xmllint" },
			-- yaml = { "yamlfix" },
		},
		formatters = {
			leptosfmt = {
				prepend_args = { "--rustfmt" },
			},
		},
	},
}
