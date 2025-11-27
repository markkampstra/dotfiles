return {
  -- Text case conversion plugin
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup({
        -- Default key prefix for all text-case commands
        default_keymappings_enabled = true,

        -- Prefix for all keymaps (default is 'ga')
        prefix = "ga",

        -- Enable telescope extension for case selection
        enabled_methods = {
          "to_upper_case",
          "to_lower_case",
          "to_snake_case",
          "to_dash_case",
          "to_title_dash_case",
          "to_constant_case",
          "to_dot_case",
          "to_phrase_case",
          "to_camel_case",
          "to_pascal_case",
          "to_title_case",
          "to_path_case",
          "to_upper_phrase_case",
          "to_lower_phrase_case",
        },
      })

      -- Load the telescope extension
      require("telescope").load_extension("textcase")

      -- Keybindings
      -- Normal mode - operates on word under cursor or selection
      vim.keymap.set("n", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Convert Text Case (Telescope)" })
      vim.keymap.set("n", "gaa", "<cmd>TextCaseOpenTelescopeQuickChange<CR>", { desc = "Quick Text Case Change" })

      -- Visual mode - operates on selection
      vim.keymap.set("v", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Convert Text Case (Telescope)" })

      -- Specific case conversions (ga + letter)
      -- These work on the current word in normal mode, or selection in visual mode
      vim.keymap.set({ "n", "v" }, "gau", "<cmd>TextCaseOpenTelescopeLSPChange<CR>", { desc = "LSP Rename with Case" })

      -- Quick access to common cases
      vim.keymap.set({ "n", "v" }, "gas", function()
        require("textcase").current_word("to_snake_case")
      end, { desc = "Convert to snake_case" })

      vim.keymap.set({ "n", "v" }, "gac", function()
        require("textcase").current_word("to_camel_case")
      end, { desc = "Convert to camelCase" })

      vim.keymap.set({ "n", "v" }, "gap", function()
        require("textcase").current_word("to_pascal_case")
      end, { desc = "Convert to PascalCase" })

      vim.keymap.set({ "n", "v" }, "gak", function()
        require("textcase").current_word("to_constant_case")
      end, { desc = "Convert to CONSTANT_CASE" })

      vim.keymap.set({ "n", "v" }, "gad", function()
        require("textcase").current_word("to_dash_case")
      end, { desc = "Convert to dash-case" })

      vim.keymap.set({ "n", "v" }, "gat", function()
        require("textcase").current_word("to_title_case")
      end, { desc = "Convert to Title Case" })

      vim.keymap.set({ "n", "v" }, "gal", function()
        require("textcase").current_word("to_lower_case")
      end, { desc = "Convert to lowercase" })

      vim.keymap.set({ "n", "v" }, "gaU", function()
        require("textcase").current_word("to_upper_case")
      end, { desc = "Convert to UPPERCASE" })
    end,
  },

  -- Add which-key integration (if you have which-key installed)
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "ga", group = "text case" },
      },
    },
  },
}
