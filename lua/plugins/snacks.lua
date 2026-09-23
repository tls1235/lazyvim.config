return {
  "folke/snacks.nvim",
  opts = {
    animate = { enabled = false },
    picker = {
      sources = {
        projects = {
          format = function(item, picker)
            local path = vim.fn.fnamemodify(item.file, ":/")
            return { { path, "SnacksPickerDirectory" } }
          end,
        },
      },
    },
  },
}
