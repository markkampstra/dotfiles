return {
  "nvim-neotest/neotest",
  lazy = true,
  dependencies = {
    "olimorris/neotest-rspec",
  },
  config = function()
    ---@diagnostic disable-next-line missing-fields
    require("neotest").setup({
      adapters = {
        require("neotest-rspec"),
      },
    })
  end,

  -- adapters = {
  --   require("neotest-rspec")({
  --     rspec_cmd = function()
  --       return vim.tbl_flatten({
  --         "bundle",
  --         "exec",
  --         "rspec",
  --       })
  --     end,
  --     root_files = { "Gemfile", ".rspec", ".gitignore" },
  --     filter_dirs = { ".git", "node_modules" },
  --     transform_spec_path = function(path)
  --       return path
  --     end,
  --     results_path = function()
  --       return async.fn.tempname()
  --     end
  --   }),
  -- }
  -- opts = {
  --   adapters = {
  --     ["neotest-rspec"] = {
  --       -- NOTE: By default neotest-rspec uses the system wide rspec gem instead of the one through bundler
  --       rspec_cmd = function()
  --         return vim.tbl_flatten({
  --           "bundle",
  --           "exec",
  --           "rspec",
  --         })
  --       end,
  --     },
  --   },
  -- },
  -- keys = {
  --   {"<leader>t", "", desc = "+test"},
  --   { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
  --   { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
  --   { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
  --   { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
  --   { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
  --   { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
  --   { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
  --   { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
  --   { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
  -- },
}
