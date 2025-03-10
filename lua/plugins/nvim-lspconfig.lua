return {
	"neovim/nvim-lspconfig",
	event = "User FilePost",
	config = function()
		require("customs.lspconfig").defaults()
	end,
}
