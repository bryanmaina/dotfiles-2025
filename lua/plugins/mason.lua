return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
	-- config = function()      -- enable mason and configure icons
	--   require("mason").setup({
	--     ui = {
	--       icons = {
	--         package_installed = "✓",
	--         package_pending = "➜",
	--         package_uninstalled = "✗",
	--       },
	--     },
	--   })

	--    require("mason-tool-installer").setup({
	--      ensure_installed = {
	--        "standardrb",
	--        "prettier",
	--        "prettierd",
	--        "ktlint",
	--        "eslint_d",
	--        "google-java-format",
	--        "htmlbeautifier",
	--        "beautysh",
	--        "buf",
	--        "rustfmt",
	--        "yamlfix",
	--        "taplo",
	--        "shellcheck",
	--        "gopls",
	--        "delve",
	--        "astro-language-server",
	-- "stylua",
	-- "lua_ls",
	--      },
	--    })
	-- end,
}
