-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Pkl filetype detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.pkl", "*.pcf", "PklProject" },
  callback = function()
    vim.bo.filetype = "pkl"
  end,
})

-- local parsers = require'nvim-treesitter.parsers'
-- function _G.ensure_treesitter_language_installed()
--   local lang = parsers.get_buf_lang()
--   if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
--     vim.schedule_wrap(function()
--     vim.cmd("TSInstall "..lang)
--     end)()
--   end
-- end
--
-- vim.cmd[[autocmd FileType * :lua ensure_treesitter_language_installed()]]
