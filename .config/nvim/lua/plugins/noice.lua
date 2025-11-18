return {
  "folke/noice.nvim",
  opts = function(_, opts)
    -- Make notify windows non-focusable
    opts.routes = opts.routes or {}
    opts.views = opts.views or {}

    -- Configure notify view to be non-focusable
    opts.views.notify = {
      backend = "notify",
    }

    return opts
  end,
  dependencies = {
    {
      "rcarriga/nvim-notify",
      opts = {
        -- Make notification windows non-focusable
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { focusable = false })
        end,
        -- Position in bottom right
        top_down = false,
        -- Faster timeout (milliseconds)
        timeout = 2000,
        -- Faster animation stages
        stages = "fade",
      },
    },
  },
}
