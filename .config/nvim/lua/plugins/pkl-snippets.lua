-- Load pkl snippets for LuaSnip
return {
  {
    "L3MON4D3/LuaSnip",
    opts = function(_, opts)
      -- Load pkl snippets from our config directory
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "pkl",
        callback = function()
          require("luasnip.loaders.from_snipmate").lazy_load({
            paths = { vim.fn.stdpath("config") .. "/snippets" }
          })
        end,
        once = false,
      })
    end,
  },
}
