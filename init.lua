vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = ";"

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("config.lazy")

-- load plugins
require("lazy").setup({
	{
		"NvChad/NvChad",
		lazy = false,
		branch = "v2.5",
		import = "nvchad.plugins",
	},

	{ import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- require "options"
require("nvchad.autocmds")

--   require "mappings"
-- end)

require("config.lazy")
require("config.options")
require("config.keymaps")

local ft_lsp_group = vim.api.nvim_create_augroup("ft_lsp_group", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	pattern = { "docker-compose.yml", "docker-compose.yaml", "compose.yaml" },
	group = ft_lsp_group,
	desc = "Fix the issue where the LSP does not start with docker-compose.",
	callback = function()
		vim.opt.filetype = "yaml.docker-compose"
	end,
})

vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#928374" })

vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = "#928374" })
