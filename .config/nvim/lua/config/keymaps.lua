-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

map("v", "<C-c>", ":w !pbcopy<CR>", { desc = "Copy to clipboard" })
map("n", "<Leader>\\", LazyVim.pick("live_grep_glob"), { desc = "Live Grep Glob" })
