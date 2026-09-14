return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = { init_options = { provideFormatter = false } },
        cssls = { init_options = { provideFormatter = false } },
        emmet_language_server = {},
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "html-lsp", "css-lsp", "emmet-language-server" } },
  },
}
