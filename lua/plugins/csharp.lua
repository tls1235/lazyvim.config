return {
  {
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
  },
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {},
  },
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:Crashdummyy/mason-registry",
        "github:mason-org/mason-registry",
      },
    },
  },
}
