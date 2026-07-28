return {
  { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.lang.nix" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nixd = {
          mason = false,
          settings = {
            nixd = {
              nixpkgs = {
                expr = "import <nixpkgs> { }",
              },
              options = {
                nixos = {
                  expr = "{ }",
                },
                home_manager = {
                  expr = '(builtins.getFlake "'
                    .. vim.fn.expand("~/.nix-config")
                    .. '").homeConfigurations.tls123.options',
                },
              },
              formatting = {
                command = { "nixfmt", "-" },
              },
            },
          },
        },
        nil_ls = false,
      },
    },
  },
}
