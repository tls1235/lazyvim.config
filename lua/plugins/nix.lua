local function get_hostname()
  local handle = io.popen("hostname")
  if not handle then
    return "unknown"
  end
  local hostname = handle:read("*l")
  handle:close()
  return hostname or "unknown"
end

local function find_flake_root()
  local path = vim.fn.expand("%:p:h")
  local root = vim.fs.find("flake.nix", { path = path, upward = true })[1]
  return root and vim.fn.fnamemodify(root, ":h") or vim.fn.getcwd()
end

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
                expr = 'import (builtins.getFlake "' .. find_flake_root() .. '").inputs.nixpkgs { }',
              },
              options = {
                nixos = {
                  expr = "{ }",
                },
                home_manager = {
                  expr = '(builtins.getFlake "'
                    .. find_flake_root()
                    .. '").homeConfigurations."tls123@'
                    .. get_hostname()
                    .. '".options',
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
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        -- Force-close and reopen the menu instead of the default show/doc-toggle chain.
        -- Fixes stale suggestions after typing, deleting, and retyping.
        ["<C-space>"] = {
          function(cmp)
            cmp.hide()
            vim.schedule(function()
              cmp.show()
            end)
          end,
        },
      },
    },
  },
}
