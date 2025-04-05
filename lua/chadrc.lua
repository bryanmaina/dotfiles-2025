-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "ayu_dark",

  hl_override = {
  	Comment = { italic = true },
  	["@comment"] = { italic = true },
  },
}
--
-- M.mason = {
--   cmd = true,
--   pkgs = {
--     "prettierd",
--     "prettier",
--     "emmet-ls",
--     "tailwindcss-language-server",
--     "rust-analyzer",
--     "jdtls",
--     "dockerfile-language-server",
--     "xmlformatter",
--     "docker-compose-language-service",
--     "stylua",
--     "typescript-language-server",
--     "lua-language-server",
--     "google-java-format"
--   },
-- }

return M
