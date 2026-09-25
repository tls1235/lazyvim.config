local function get_hostname()
  local handle = io.popen("hostname")
  if not handle then
    return "unknown"
  end
  local hostname = handle:read("*l")
  handle:close()
  return hostname or "unknown"
end

local function get_username()
  local handle = io.popen("whoami")
  if not handle then
    return "unknown"
  end
  local username = handle:read("*l")
  handle:close()
  return username or "unknown"
end

local function find_flake_root(path)
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
          on_new_config = function(new_config, root_dir)
            local flake_root = find_flake_root(root_dir)
            new_config.settings.nixd.nixpkgs.expr = 'import (builtins.getFlake "'
              .. flake_root
              .. '").inputs.nixpkgs { }'
            new_config.settings.nixd.options.home_manager.expr = '(builtins.getFlake "'
              .. flake_root
              .. '").homeConfigurations."'
              .. get_username()
              .. "@"
              .. get_hostname()
              .. '".options'
          end,
          settings = {
            nixd = {
              nixpkgs = {},
              options = {
                nixos = {
                  expr = "{ }",
                },
                home_manager = {},
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
      completion = {
        ghost_text = {
          enabled = function()
            return not vim.g.copilot_enabled
          end,
        },
      },
      keymap = {
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
