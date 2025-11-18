return {
  "3rd/image.nvim",
  build = false, -- Use this if using magick_cli processor (default)
  opts = {
    backend = "ueberzug", -- or "kitty" if you use Kitty terminal
    processor = "magick_cli", -- Use ImageMagick CLI
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
      },
      neorg = {
        enabled = false,
      },
      html = {
        enabled = false,
      },
      css = {
        enabled = false,
      },
    },
    max_width_window_percentage = nil,
    max_height_window_percentage = 50,
    window_overlap_clear_enabled = true,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  },
}
