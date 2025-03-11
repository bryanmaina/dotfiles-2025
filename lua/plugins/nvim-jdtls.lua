return {
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	keys = {
		{
			"<leader>tc",
			function()
				require("jdtls.tests").generate()
			end,
			desc = "Generate tests",
			mode = { "n" },
		},
		{
			"<leader>to",
			function()
				require("jdtls.tests").goto_subjects()
			end,
			desc = "Jump to tests or subjects",
			mode = { "n" },
		},
	},
	config = function()
		-- local o = vim.o
		-- o.expandtab = true
		-- o.shiftwidth = 4
		-- o.smartindent = true
		-- o.tabstop = 4
		-- o.softtabstop = 4

		local home = os.getenv("HOME")
		local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = workspace_path .. project_name

		local status, jdtls = pcall(require, "jdtls")
		if not status then
			return
		end
		local extendedClientCapabilities = jdtls.extendedClientCapabilities
		local bundles = {
			vim.fn.glob(
				home
					.. "/.vscode-server/extensions/vscjava.vscode-java-debug-0.58.1/server/com.microsoft.java.debug.plugin-*.jar",
				1
			),
		}
		vim.list_extend(
			bundles,
			vim.split(
				vim.fn.glob(home .. "/.vscode-server/extensions/vscjava.vscode-java-test-0.43.0/server/*.jar", 1),
				"\n"
			)
		)

		local config = {
			cmd = {
				home .. "/.sdkman/candidates/java/current/bin/java",
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xmx1g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",
				"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
				"-jar",
				vim.fn.glob(
					home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
				),
				"-configuration",
				home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
				"-data",
				workspace_dir,
			},
			root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

			settings = {
				java = {
					signatureHelp = { enabled = true },
					extendedClientCapabilities = extendedClientCapabilities,
					maven = {
						downloadSources = true,
					},
					referencesCodeLens = {
						enabled = true,
					},
					references = {
						includeDecompiledSources = true,
					},
					inlayHints = {
						parameterNames = {
							enabled = "all", -- literals, all, none
						},
					},
					format = {
						enabled = false,
					},
				},
			},

			init_options = {
				bundles = bundles,
			},
		}
		require("jdtls").start_or_attach(config)
	end,
}
