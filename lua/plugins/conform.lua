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
			lua = { "stylua" },
			svelte = { "prettierd" },
			astro = { "prettierd" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			json = { "prettierd" },
			graphql = { "prettierd" },
			java = { "google-java-format" },
			kotlin = { "ktlint" },
			ruby = { "standardrb" },
			markdown = { "prettierd" },
			erb = { "htmlbeautifier" },
			html = { "htmlbeautifier" },
			bash = { "beautysh" },
			proto = { "buf" },
			rust = { "rustfmt" },
			yaml = { "yamlfix" },
			toml = { "taplo" },
			css = { "prettierd" },
			scss = { "prettierd" },
			sh = { "shellcheck" },
			go = { "gofmt" },
			xml = { "xmllint" },
		},
	},
}
