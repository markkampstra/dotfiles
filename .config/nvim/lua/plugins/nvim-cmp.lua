return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "f3fora/cmp-spell",
  },
  opts = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Icons from font bundled with kitty
    local lsp_kinds = {
      Class = " ",
      Color = " ",
      Constant = " ",
      Constructor = " ",
      Enum = " ",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = " ",
      Folder = " ",
      Function = " ",
      Interface = " ",
      Keyword = " ",
      Method = " ",
      Module = " ",
      Operator = " ",
      Property = " ",
      Reference = " ",
      Snippet = " ",
      Struct = " ",
      Text = " ",
      TypeParameter = " ",
      Unit = " ",
      Value = " ",
      Variable = " ",
    }

    -- Helper functions
    local column = function()
      local _line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col
    end

    local in_whitespace = function()
      local col = column()
      return col == 0 or vim.api.nvim_get_current_line():sub(col, col):match("%s")
    end

    local in_leading_indent = function()
      local col = column()
      local line = vim.api.nvim_get_current_line()
      local prefix = line:sub(1, col)
      return prefix:find("^%s*$")
    end

    local shift_width = function()
      if vim.o.softtabstop <= 0 then
        return vim.fn.shiftwidth()
      else
        return vim.o.softtabstop
      end
    end

    local smart_bs = function(dedent)
      local keys = nil
      if vim.o.expandtab then
        if dedent then
          keys = vim.api.nvim_replace_termcodes("<C-D>", true, false, true)
        else
          keys = vim.api.nvim_replace_termcodes("<BS>", true, false, true)
        end
      else
        local col = column()
        local line = vim.api.nvim_get_current_line()
        local prefix = line:sub(1, col)
        if in_leading_indent() then
          keys = vim.api.nvim_replace_termcodes("<BS>", true, false, true)
        else
          local previous_char = prefix:sub(#prefix, #prefix)
          if previous_char ~= " " then
            keys = vim.api.nvim_replace_termcodes("<BS>", true, false, true)
          else
            keys = vim.api.nvim_replace_termcodes(
              "<C-\\><C-o>:set expandtab<CR><BS><C-\\><C-o>:set noexpandtab<CR>",
              true,
              false,
              true
            )
          end
        end
      end
      vim.api.nvim_feedkeys(keys, "nt", true)
    end

    local smart_tab = function()
      local keys = nil
      if vim.o.expandtab then
        keys = "<Tab>"
      else
        local col = column()
        local line = vim.api.nvim_get_current_line()
        local prefix = line:sub(1, col)
        local in_leading_indent = prefix:find("^%s*$")
        if in_leading_indent then
          keys = "<Tab>"
        else
          local sw = shift_width()
          local previous_char = prefix:sub(#prefix, #prefix)
          local previous_column = #prefix - #previous_char + 1
          local current_column = vim.fn.virtcol({ vim.fn.line("."), previous_column }) + 1
          local remainder = (current_column - 1) % sw
          local move = remainder == 0 and sw or sw - remainder
          keys = (" "):rep(move)
        end
      end
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "nt", true)
    end

    local confirm = function(entry)
      local behavior = cmp.ConfirmBehavior.Replace
      if entry then
        local completion_item = entry.completion_item
        local newText = ""
        if completion_item.textEdit then
          newText = completion_item.textEdit.newText
        elseif type(completion_item.insertText) == "string" and completion_item.insertText ~= "" then
          newText = completion_item.insertText
        else
          newText = completion_item.word or completion_item.label or ""
        end

        local diff_after = math.max(0, entry.replace_range["end"].character + 1) - entry.context.cursor.col
        if entry.context.cursor_after_line:sub(1, diff_after) ~= newText:sub(-diff_after) then
          behavior = cmp.ConfirmBehavior.Insert
        end
      end
      cmp.confirm({ select = true, behavior = behavior })
    end

    return {
      experimental = {
        ghost_text = true,
      },
      formatting = {
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s %s", lsp_kinds[vim_item.kind], vim_item.kind)
          vim_item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            spell = "[Spell]",
          })[entry.source.name]
          return vim_item
        end,
      },
      mapping = {
        ["<BS>"] = cmp.mapping(function()
          smart_bs()
        end, { "i", "s" }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-e>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.close()
          elseif luasnip.choice_active() then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end),
        ["<Down>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end),
        ["<Up>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end),
        ["<C-y>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            confirm(entry)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.in_snippet() and luasnip.jumpable(-1) then
            luasnip.jump(-1)
          elseif in_leading_indent() then
            smart_bs(true)
          elseif in_whitespace() then
            smart_bs()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            local entries = cmp.get_entries()
            if #entries == 1 then
              confirm(entries[1])
            else
              cmp.select_next_item()
            end
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif in_whitespace() then
            smart_tab()
          else
            cmp.complete()
          end
        end, { "i", "s" }),
        -- ["<CR>"] = cmp.mapping(function(fallback)
        --   if cmp.visible() then
        --     local entry = cmp.get_selected_entry()
        --     confirm(entry)
        --   else
        --     fallback()
        --   end
        -- end, { "i", "s"}),
      },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = "buffer" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "calc" },
        { name = "emoji" },
        { name = "path" },
        {
          name = "spell",
          option = {
            keep_all_entries = false,
            enable_in_context = function()
              return true
            end,
            preselect_correct_word = true,
          },
        },
      }),
      window = {
        completion = cmp.config.window.bordered({
          border = "single",
          col_offset = -1,
          scrollbar = false,
          scrolloff = 3,
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          border = "solid",
          scrollbar = false,
          winhighlight = "CursorLine:Visual,Search:None",
        }),
      },
    }
  end,
  config = function(_, opts)
    local cmp = require("cmp")
    cmp.setup(opts)

    -- Ghost text toggle functionality
    local toggle_ghost_text = function()
      if vim.api.nvim_get_mode().mode ~= "i" then
        return
      end

      local cursor_column = vim.fn.col(".")
      local current_line_contents = vim.fn.getline(".")
      local character_after_cursor = current_line_contents:sub(cursor_column, cursor_column)

      local should_enable_ghost_text = character_after_cursor == ""
        or vim.fn.match(character_after_cursor, [[\k]]) == -1

      local current = require("cmp.config").get().experimental.ghost_text
      if current ~= should_enable_ghost_text then
        require("cmp.config").set_global({
          experimental = {
            ghost_text = should_enable_ghost_text,
          },
        })
      end
    end

    vim.api.nvim_create_autocmd({ "InsertEnter", "CursorMovedI" }, {
      callback = toggle_ghost_text,
    })
  end,
}
