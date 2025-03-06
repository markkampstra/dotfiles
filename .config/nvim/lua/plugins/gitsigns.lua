return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- Lazy load for files and buffers
    config = function()
      require("gitsigns").setup()
    end,
  }
}
