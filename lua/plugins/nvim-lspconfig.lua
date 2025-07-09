return {
	"neovim/nvim-lspconfig",
	events = "VeryLazy", -- Load this plugin on the 'VeryLazy' event
	-- event = "User FilePost",
	config = function()
		require("customs.lspconfig").defaults()
	end,
	opts = {
		servers = {
			-- angularls = {},
			-- Configuration for the bashls [Shell]
			bashls = {},
			-- Configuration for the dockerls [Docker]
			dockerls = {
				settings = {
					docker = {
						languageserver = {
							formatter = {
								ignoreMultilineInstructions = true,
							},
						},
					},
				},
			},

			-- pylsp = {
			-- 	settings = {
			-- 		pylsp = {
			-- 			plugins = {
			-- 				pyflakes = { enabled = false },
			-- 				pycodestyle = { enabled = false },
			-- 				autopep8 = { enabled = false },
			-- 				yapf = { enabled = false },
			-- 				mccabe = { enabled = false },
			-- 				pylsp_mypy = { enabled = false },
			-- 				pylsp_black = { enabled = false },
			-- 				pylsp_isort = { enabled = false },
			-- 			},
			-- 		},
			-- 	},
			-- },

			-- jdtls = {
			-- 	settings = {
			-- 		java = {
			-- 			configuration = {
			-- 				runtimes = {
			-- 					{
			-- 						name = "JavaSE-21",
			-- 						path = "/home/mainab/.sdkman/candidates/java/21.0.7-tem/",
			-- 					},
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- },
			docker_compose_language_service = {},
			-- Configuration for the yamlls [Yaml]
			yamlls = {
				settings = {
					yaml = {
						schemas = {
							-- Schema for GitHub Actions
							["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",

							-- Schema for Kubernetes
							["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/v1.32.1-standalone-strict/all.json"] = "/*.k8s.yaml",

							-- [*] Schema for file YAML
							-- ["../path/relative/to/file.yml"] = "/.github/workflows/*",
							-- ["/path/from/root/of/project"] = "/.github/workflows/*",
						},
						redhat = {
							telemetry = {
								enabled = false,
							},
						},
					},
				},
				single_file_support = true,
			},
		},
		-- setup = {
		-- 	angularls = function()
		-- 		LazyVim.lsp.on_attach(function(client)
		-- 			--HACK: disable angular renaming capability due to duplicate rename popping up
		--         client.server_capabilities.renameProvider = false
		--       end, "angularls")
		--     end,
		-- 	jdtls = function()
		-- 		require("java").setup({})
		-- 	end,
		-- },
	},
}
