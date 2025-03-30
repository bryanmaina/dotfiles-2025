local map = vim.keymap.set

map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })

-- Lspsaga
require('lspsaga.codeaction')
map("n", "<leader>a", "<cmd>Lspsaga code_action<CR>", { desc = "[C]ode [A]ction" })
map("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })
map("n", "<Leader>o", "<cmd>Lspsaga outline<CR>", { desc = "Toogle [O]utline" })
