return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function(_)
      vim.cmd("TSUpdate")
    end,
    opts = {
      ensure_installed = { "ruby", "php", "lua", "vim", "vimdoc", "query" },
      sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
      ignore_install = { "" }, -- List of parsers to ignore installing
      autopairs = {
        enable = true,
      },
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
      },
      -- indent = { enable = true, disable = { "yaml", "ruby" } },
      indent = { enable = true, disable = { "yaml", "ruby" } },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      foldmethod = "expr",
      foldexpr = "nvim_treesitter#foldexpr()",
    },
    -- opts = function(_, opts)
    --   vim.list_extend(opts.ensure_installed, {
    --     "ruby",
    --     "ninja",
    --     "python",
    --     "toml",
    --     "jsonc",
    --     "markdown",
    --     "lua",
    --     "regex",
    --   })
    -- end,
    -- autopairs = { enabled = true }
  },
}
