local map = vim.keymap.set

map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
