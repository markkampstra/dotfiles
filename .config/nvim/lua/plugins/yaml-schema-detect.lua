return {
  "cwrau/yaml-schema-detect.nvim",
  ---@module "yaml-schema-detect"
  ---@type YamlSchemaDetectOptions
  opts = {}, -- use default options
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ft = { "yaml" },
  schemas = {
    ["https://json.schemastore.org/kustomization.json"] = "kustomization.[yaml,yml]",
    ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
    ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
    ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
    ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
    ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
  },
}
