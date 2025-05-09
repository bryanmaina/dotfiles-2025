return {
	"neovim/nvim-lspconfig",
	events = "VeryLazy", -- Load this plugin on the 'VeryLazy' event
	-- event = "User FilePost",
	config = function()
		require("customs.lspconfig").defaults()
	end,
	opts = {
		servers = {
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
	},
}
