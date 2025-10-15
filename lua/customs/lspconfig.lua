local M = {}
local map = vim.keymap.set

-- export on_attach & capabilities
M.on_attach = function(client, bufnr)
	-- vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		map("n", keys, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
	end

	-- Useful LSP Keymaps
	-- nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	-- nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
	-- nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

	-- nmap("<leader>a", vim.lsp.buf.code_action, "[C]ode [A]ction")
	-- nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	-- nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	-- nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	nmap("<leader>mr", vim.lsp.codelens.run, "[R]un [C]odelens")
	nmap("<Leader>ih", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, "[I]nlay [H]ints")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	-- nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Diagnostics
	-- nmap("gl", vim.diagnostic.open_float, "[O]pen [D]iagnostics")
	nmap("[d", function()
		vim.diagnostic.jump({ count = 1, float = true })
	end, "[G]oto [P]revious Diagnostics")
	nmap("]d", function()
		vim.diagnostic.jump({ count = -1, float = true })
	end, "[G]oto [N]ext Diagnostics")

	-- Enable Inalay Hints if the lsp server supports it
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true)
	end

	if client.name == "ruff" then
		client.server_capabilities.hoverProvider = false
	end
end

-- disable semanticTokens
M.on_init = function(client, _)
	if client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
-- M.capabilities.offsetEncoding = { "utf-8" }
-- M.capabilities.general.positionEncodings = { "utf-8" }
M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

M.defaults = function()
	dofile(vim.g.base46_cache .. "lsp")
	require("nvchad.lsp").diagnostic_config()

	local lspconfig = require("lspconfig")

	lspconfig.dockerls.setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
		settings = {
			docker = {
				languageserver = {
					formatter = {
						ignoreMultilineInstructions = true,
					},
				},
			},
		},
	})

	lspconfig.pyright.setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
		settings = {
			pyright = {
				disableOrganizeImports = true,
			},
			python = {
				analysis = {
					ignore = { "*" },
				},
			},
		},
	})

	lspconfig.ruff.setup({
		on_init = M.on_init,
		capabilities = M.capabilities,
		on_attach = M.on_attach,
	})

	lspconfig.angularls.setup({
		on_init = M.on_init,
		capabilities = M.capabilities,
		on_attach = M.on_attach,
	})

	lspconfig.jdtls.setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
		settings = {
			java = {
				configuration = {
					runtimes = {
						{
							name = "JavaSE-21",
							path = "/home/mainab/.sdkman/candidates/java/21.0.7-tem",
							default = true,
						},
					},
				},
			},
		},
	})

	lspconfig.lua_ls.setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,

		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
						vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
						vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
						"${3rd}/luv/library",
					},
					maxPreload = 100000,
					preloadFileSize = 10000,
				},
			},
		},
	})

	lspconfig.tailwindcss.setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
		filetypes = {
			"css",
			"scss",
			"sass",
			"postcss",
			"html",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"svelte",
			"vue",
			"rust",
			-- "rs",
		},
		experimental = {
			classRegex = {
				[[class="([^"]*)]],
				'class=\\s+"([^"]*)',
			},
		},
		root_dir = require("lspconfig").util.root_pattern(
			"tailwind.config.js",
			"tailwind.config.ts",
			"postcss.config.js",
			"postcss.config.ts",
			"package.json",
			"node_modules"
		),
	})

	lspconfig["cssls"].setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
		filetypes = {
			"rust",
			"scss",
			"css",
		},
	})

	lspconfig["html"].setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
	})

	lspconfig.ts_ls.setup({
		on_attach = M.on_attach,
		on_init = M.on_init,
		capabilities = M.capabilities,
	})

	lspconfig.emmet_ls.setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
		filetypes = {
			"html",
			"htmlangular",
			"typescript",
			"typescriptreact",
			"javascriptreact",
			"css",
			"sass",
			"scss",
			"less",
			"svelte",
			"rust",
		},
	})
end

return M
