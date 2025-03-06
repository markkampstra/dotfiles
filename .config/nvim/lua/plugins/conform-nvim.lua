return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },

  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>m",
      function()
        require("conform").format({ async = true, lsp_fallback = false })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      ruby = { { "prettier" } },
      php = { { "prettier" } },
      html = { { "prettier" } },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
}
