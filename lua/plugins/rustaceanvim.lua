return {
	"mrcjkb/rustaceanvim",
	version = "^5", -- Recommended
	lazy = false, -- This plugin is already lazy
	dependencies = {
		-- needed by neotest
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- needed by rustaceanvim
		"nvim-neotest/neotest",
	},
	build = "rustup component add rust-analyzer",
	ft = { "rust" },
	keys = {
		-- { "<Leader>rt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", desc = "Run rust tests", mode = { "n" } },
		{
			"<leader>ca",
			function()
				vim.cmd.RustLsp("codeAction")
			end,
			desc = "Grouped Code Actions",
			mode = { "n" },
		},
		{
			"<leader>rt",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run current file tests",
			mode = { "n" },
		},
		{
			"<leader>rn",
			function()
				require("neotest").run.run()
			end,
			desc = "Run the nearest test",
			mode = { "n" },
		},
		{
			"<leader>rs",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle test summary window",
			mode = { "n" },
		},
		{
			"<leader>rw",
			function()
				require("neotest").watch.toggle(vim.fn.expand("%"))
			end,
			desc = "Toggle test summary window and watch",
			mode = { "n" },
		},
	},
	config = function()
		local extension_path = vim.env.HOME .. "/.vscode-server/extensions/vadimcn.vscode-lldb-1.11.4/"
		local codelldb_path = extension_path .. "adapter/codelldb"
		local liblldb_path = extension_path .. "lldb/lib/liblldb"
		local this_os = vim.uv.os_uname().sysname

		-- The path is different on Windows
		if this_os:find("Windows") then
			codelldb_path = extension_path .. "adapter\\codelldb.exe"
			liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
			-- else
			-- The liblldb extension is .so for Linux and .dylib for MacOS
			-- liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
		end

		local cfg = require("rustaceanvim.config")
		require("neotest").setup({
			adapters = {
				require("rustaceanvim.neotest"),
			},
		})

		vim.g.rustaceanvim = {
			dap = {
				adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
			},
			server = {
				default_settings = {
					["rust-analyzer"] = {
						-- checkOnSave = {
						--   allFeatures = true,
						--   command = "clipy",
						-- },
						rustfmt = {
							overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
						},
						cargo = {
							-- autoreload = true,
							allFeatures = true,
							-- features = {
							--   "all",
							--   "ssr",
							--   "hydrate",
							-- },
						},
						hoverActions = {
							enabled = true,
						},
						-- procMacro = {
						--   enabled = true,
						--   ignored = {
						--     leptos_macro = {
						--       -- "all",
						--       -- optional:
						--       "component",
						--       -- "server",
						--     },
						--   },
						-- },
						callInfo = {
							full = true,
						},
						-- Enable CodeLens and its various sub things
						-- "rust-analyzer.lens.enabled" = true,
						-- "rust-analyzer.lens.references" = true,
						-- "rust-analyzer.lens.implementations" = true,
						-- "rust-analyzer.lens.enumVariantReferences" = true,
						-- "rust-analyzer.lens.methodReferences" = true,
						lens = {
							enabled = true,
							references = true,
							implementations = true,
							enumVariantReferences = true,
							methodReferences = true,
						},
						-- Enable inlay hints
						-- "rust-analyzer.inlayHints.enable" = true,
						-- "rust-analyzer.inlayHints.typeHints" = true,
						-- "rust-analyzer.inlayHints.parameterHints" = true,
						inlayHints = {
							enabled = true,
							typeHints = true,
							parameterHints = true,
						},
						-- Reload rust-analyzer if the Cargo.toml/Cargo.lock file changes
						-- "rust-analyzer.cargo.autoreload" = true,
						-- Hover Actions!
						-- "rust-analyzer.hoverActions.enable" = true,
					},
				},
			},
		}
	end,
}
