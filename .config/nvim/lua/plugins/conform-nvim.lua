return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },

  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>m",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      -- ruby = { "prettier" },
      eruby = { "erb_format" },
      php = { "prettier" },
      html = { "prettier" },
      haml = { "haml-lint" },
      js = { "prettier" },
      javascript = { "prettier" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
}
