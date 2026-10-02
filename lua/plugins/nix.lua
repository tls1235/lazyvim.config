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

-- Returns the nearest flake root above `path`, or nil if there is none.
local function find_flake_root(path)
  local root = vim.fs.find("flake.nix", { path = path, upward = true })[1]
  return root and vim.fn.fnamemodify(root, ":h") or nil
end

return {
  { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.lang.nix" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nixd = {
          mason = false,
          before_init = function(params, config)
            local root_dir = config.root_dir or params.rootPath or vim.fn.getcwd()

            -- nixpkgs: use the project's flake if it has one, else the registered config flake.
            local flake_root = find_flake_root(root_dir)
            local nixpkgs_flake = flake_root and ('(builtins.getFlake "' .. flake_root .. '")')
              or '(builtins.getFlake "nixconfig")'

            -- Mutate in place: nixd reads these tables via workspace/configuration.
            config.settings.nixd.nixpkgs.expr = "import " .. nixpkgs_flake .. ".inputs.nixpkgs { }"

            -- home-manager options: always from the registered `nixconfig` flake.
            config.settings.nixd.options.home_manager.expr = '(builtins.getFlake "nixconfig").homeConfigurations."'
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
