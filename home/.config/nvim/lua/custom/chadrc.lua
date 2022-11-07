-- make sure you maintain the structure of `core/default_config.lua` here,

local M = {}

M.ui = {
  theme = "tokyonight",
  transparency = false,
}

M.plugins = {
  ["goolord/alpha-nvim"] = {
    -- enable dashboard
    disable = false,
    override_options = {
      headerPaddingTop = { type = "padding", val = 2 },
    },
  },
  ["kyazdani42/nvim-tree.lua"] = {
    -- disable lazy loading by running at "VimEnter" event
    -- so "nvim ." or "nvim <dir>" works
    event = "VimEnter",
    override_options = {
      view = {
        adaptive_size = false,
        width = 30,
        hide_root_folder = false,
      },
      git = {
        enable = true,
        ignore = false,
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = "all",
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            git = true,
          },
          git_placement = "signcolumn",
        },
      },
    },
  },
}

return M
