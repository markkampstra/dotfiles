return {
  -- Treesitter parser for Pkl syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "pkl" })
      return opts
    end,
  },

  -- Official Pkl language support from Apple
  {
    "apple/pkl-neovim",
    lazy = true,
    event = "BufReadPre *.pkl",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    build = function()
      vim.cmd("TSInstall! pkl")
    end,
    init = function()
      -- Set up filetype detection for Pkl files
      vim.filetype.add({
        extension = {
          pkl = "pkl",
        },
        pattern = {
          [".*%.pkl"] = "pkl",
        },
      })
    end,
    config = function()
      -- Configure the Pkl LSP start command with Java 25 and the latest JAR
      vim.g.pkl_neovim = {
        start_command = {
          "/opt/homebrew/opt/openjdk/bin/java",
          "-jar",
          "/Users/Mark.Kampstra/Development/LanguageServers/pkl-lsp-0.5.1.jar",
        },
      }

      -- Enable diagnostics specifically for Pkl files (overriding global disabled diagnostics)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "pkl",
        callback = function()
          vim.diagnostic.config({
            virtual_text = true,
            underline = true,
            signs = true,
            update_in_insert = false,
            severity_sort = true,
          })
        end,
      })
    end,
  },

}
