return {
  "pinecoders/vim-pine-script",
  ft = "psl",
  init = function()
    vim.filetype.add({
      extension = {
        pine = "psl",
      },
    })
  end,
}
