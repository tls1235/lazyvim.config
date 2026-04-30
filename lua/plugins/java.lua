return {
  { import = "lazyvim.plugins.extras.lang.java" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "java" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        jdtls = {},
      },
      setup = {
        jdtls = function()
          return true -- avoid duplicate servers
        end,
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "java-debug-adapter", "java-test" } },
  },
}
