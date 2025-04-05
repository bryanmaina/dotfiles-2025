local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
