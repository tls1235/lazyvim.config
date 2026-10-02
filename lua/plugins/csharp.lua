-- return {
--   {
--     "stevearc/conform.nvim",
--     opts = {
--       formatters = {
--         csharpier = {
--           command = vim.fn.expand("~/.dotnet/tools/csharpier"),
--           args = { "format", "--write-stdout" },
--           stdin = true,
--         },
--       },
--       formatters_by_ft = {
--         cs = { "csharpier" },
--       },
--     },
--   },
--   {
--     "seblyng/roslyn.nvim",
--     ft = "cs",
--     opts = {},
--   },
--   {
--     "mason-org/mason.nvim",
--     opts = {
--       registries = {
--         "github:Crashdummyy/mason-registry",
--         "github:mason-org/mason-registry",
--       },
--     },
--   },
-- }
vim.filetype.add({
  extension = { cshtml = "razor", razor = "razor" },
})

return {
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ensure_installed = { "roslyn", "csharpier", "html-lsp" },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
    },
  },
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    opts = {},
    config = function(_, opts)
      vim.lsp.config("roslyn", {
        settings = {
          -- ["csharp|background_analysis"] = {
          --   dotnet_analyzer_diagnostics_scope = "openFiles",
          --   dotnet_compiler_diagnostics_scope = "openFiles",
          -- },
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
          },
          ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
          },
        },
      })
      require("roslyn").setup(opts)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = { filetypes = { "html", "razor" } },
      },
    },
  },
}
