local M = {}
local map = vim.keymap.set

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }
	vim.keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action()
	end, vim.tbl_deep_extend("force", opts, { desc = "LSP Code Action" }))
	-- map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
	-- map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
	-- map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
	-- map("n", "<leader>sh", vim.lsp.buf.signature_help, "LSP Show signature help"))
	-- map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
	-- map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
	--
	-- map("n", "<leader>wl", function()
	-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, opts("List workspace folders"))
	--
	-- map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
	-- map("n", "<leader>ra", require("nvchad.lsp.renamer"), opts("NvRenamer"))
	--
	-- map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
	-- map("n", "gr", vim.lsp.buf.references, opts("Show references"))
end

-- disable semanticTokens
M.on_init = function(client, _)
	if client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

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

	-- lspconfig["cssls"].setup({
	-- 	on_attach = M.on_attach,
	-- 	capabilities = M.capabilities,
	-- 	on_init = M.on_init,
	-- 	filetypes = {
	-- 		"rust",
	-- 	},
	-- })

	-- lspconfig["html"].setup({
	-- 	on_attach = M.on_attach,
	-- 	capabilities = M.capabilities,
	-- 	on_init = M.on_init,
	-- })

	lspconfig.emmet_ls.setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
		filetypes = {
			"html",
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
