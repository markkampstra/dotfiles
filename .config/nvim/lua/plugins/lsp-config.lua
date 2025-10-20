local lspconfig = require("lspconfig")

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    --[[
      Workaround for Mason change
      https://github.com/LazyVim/LazyVim/issues/6039#issuecomment-2856227817
    ]]--
    -- { 'mason-org/mason.nvim', config = true, version = "^1.0.0" }, -- NOTE: Must be loaded before dependants
    -- { 'mason-org/mason-lspconfig.nvim', version = "^1.0.0" },
    -- 'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  opts = {
    diagnostics = {
      virtual_text = false,
      underline = false,
    },
    servers = {
      rubocop = {
        -- See: https://docs.rubocop.org/rubocop/usage/lsp.html
        cmd = { "bundle", "exec", "rubocop", "--lsp" },
        root_dir = lspconfig.util.root_pattern("Gemfile", ".git", "."),
      },
      solargraph = {
        cmd = { "bundle", "exec", "solargraph", "stdio" },
        useBundler = true,
      },

      pkl = {
        cmd = { "/opt/homebrew/opt/openjdk/bin/java", "-jar", "/Users/Mark.Kampstra/Development/LanguageServers/pkl-lsp-0.4.0.jar" },
        filetypes = { "pkl" },
        root_dir = lspconfig.util.root_pattern("PklProject", "PklProject.deps.json", ".git"),
      },

      yamlls = {
        -- Have to add this for yamlls to understand that we support line folding
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
        -- lazy-load schemastore when needed
        on_new_config = function(new_config)
          new_config.settings.yaml.schemas =
            vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
        end,
        settings = {
          redhat = { telemetry = { enabled = false } },
          yaml = {
            keyOrdering = false,
            format = {
              enable = true,
            },
            validate = true,
            schemaStore = {
              -- Must disable built-in schemaStore support to use
              -- schemas from SchemaStore.nvim plugin
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
            schemas = {
              kubernetes = "*.yaml",
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
              ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
              ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
              ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
              ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
              ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
              ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
            },
          },
        },
      },
    },
    setup = {
      yamlls = function()
        -- Neovim < 0.10 does not have dynamic registration for formatting
        if vim.fn.has("nvim-0.10") == 0 then
          LazyVim.lsp.on_attach(function(client, _)
            client.server_capabilities.documentFormattingProvider = true
          end, "yamlls")
        end
      end,
    },
  },
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- change a keymap
    keys[#keys + 1] = { "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>' }
  end,
}
-- local nvim_lsp = require("lspconfig")
--  nvim_lsp.solargraph.setup {
--      root_dir = nvim_lsp.util.root_pattern("Gemfile", ".git", "."),
--      settings = {
--          solargraph = {
--              useBundler = true
--          }
--      }
--  }
-- return {
--   "neovim/nvim-lspconfig",
--   opts = {
--     inlay_hints = { enabled = false },
--   },
-- }
