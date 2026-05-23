-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- UI
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn = 'yes'
vim.o.colorcolumn = '80'
vim.o.wrap = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.scrolloff = 10
vim.o.mouse = 'a'
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevelstart = 99

-- Editing
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.textwidth = 80
vim.o.undofile = true
vim.o.confirm = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'

-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Packages
vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('nvim.difftool')

vim.pack.add({
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/folke/flash.nvim',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
})

-- Oil (file explorer sidebar)
require('oil').setup({
  view_options = {
    show_hidden = true,
  },
  float = {
    padding = 0,
    max_width = 40,
    max_height = 0,
    border = 'none',
    win_options = {
      winblend = 0,
    },
    override = function(conf)
      conf.anchor = 'NE'
      conf.relative = 'editor'
      conf.row = 0
      conf.col = vim.o.columns
      conf.width = 40
      conf.height = vim.o.lines - vim.o.cmdheight - 1
      conf.border = 'none'
      return conf
    end,
  },
})
vim.keymap.set('n', '\\', function() require('oil').toggle_float() end, { desc = 'Toggle Oil sidebar' })

-- LSP (mason installs servers, mason-lspconfig connects them to nvim)
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'ts_ls' },
})

-- LSP keymaps (activate when an LSP server attaches to a buffer)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
  end,
})

-- Telescope (fuzzy finder)
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by grep' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Search buffers' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search help' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search diagnostics' })

-- Gitsigns
require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = require('gitsigns')
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    map('n', ']c', function() gs.nav_hunk('next') end, { desc = 'Next git hunk' })
    map('n', '[c', function() gs.nav_hunk('prev') end, { desc = 'Prev git hunk' })
    map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk' })
    map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk' })
    map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, { desc = 'Blame line' })
    map('n', '<leader>hd', gs.diffthis, { desc = 'Diff this' })
  end,
})

-- Mini plugins
require('mini.move').setup()
require('mini.pairs').setup()
require('mini.statusline').setup()
require('mini.starter').setup()
require('mini.surround').setup()
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

-- Flash (deferred — vim.pack.add defaults to load=false during init.lua)
vim.schedule(function()
  vim.cmd.packadd('flash.nvim')
  require('flash').setup({})

  vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end, { desc = 'Flash' })
  vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })
  vim.keymap.set('o', 'r', function() require('flash').remote() end, { desc = 'Remote Flash' })
  vim.keymap.set({ 'o', 'x' }, 'R', function() require('flash').treesitter_search() end, { desc = 'Treesitter Search' })
  vim.keymap.set('c', '<c-s>', function() require('flash').toggle() end, { desc = 'Toggle Flash Search' })
end)
