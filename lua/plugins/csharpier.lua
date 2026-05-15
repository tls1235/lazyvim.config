return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      csharpier = {
        command = vim.fn.expand("~/.dotnet/tools/csharpier"),
        args = { "format", "--write-stdout" },
        stdin = true,
      },
    },
    formatters_by_ft = {
      cs = { "csharpier" },
    },
  },
}
