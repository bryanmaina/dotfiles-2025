return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	opts = function()
		dofile(vim.g.base46_cache .. "mason")
		return {
			-- PATH = "skip",
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
			-- max_concurrent_installers = 10,
		}
	end,
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
