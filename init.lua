
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Global settings
vim.g.mapleader = " "

-- Load plugins
require("lazy").setup({
	{ 
		"nvim-tree/nvim-web-devicons", lazy = true 
	},
	{ 
		"nvim-lua/plenary.nvim" 
	},
	{
		"folke/neoconf.nvim",
		cmd = "Neoconf" 
	},
	{
		"folke/neodev.nvim"
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = function()
			require("nvim-tree").setup {}
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{
		'akinsho/bufferline.nvim', 
		dependencies = { 'nvim-tree/nvim-web-devicons' },
	},
	{
		'lewis6991/gitsigns.nvim'
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		opts = {}
	},
	{
		"sindrets/diffview.nvim"
	},
	{
		"rafamadriz/friendly-snippets"
	},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" }
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {}
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		dependencies = {
			-- LSP Support
			'neovim/nvim-lspconfig',             -- Required
			'williamboman/mason.nvim',           -- Optional
			'williamboman/mason-lspconfig.nvim', -- Optional

			-- Autocompletion
			'hrsh7th/nvim-cmp',         -- Required
			'hrsh7th/cmp-nvim-lsp',     -- Required
			'hrsh7th/cmp-buffer',       -- Optional
			'hrsh7th/cmp-path',         -- Optional
			'saadparwaiz1/cmp_luasnip', -- Optional
			'hrsh7th/cmp-nvim-lua',     -- Optional

			-- Snippets
			'L3MON4D3/LuaSnip',             -- Required
			'rafamadriz/friendly-snippets', -- Optional
		}
	},
	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',

			-- Adds a number of user-friendly snippets
			'rafamadriz/friendly-snippets',
		},
	},
	{
		'folke/trouble.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {}
	},
	{
		'NvChad/nvim-colorizer.lua',
		opts = {}
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
  {
    'akinsho/toggleterm.nvim', 
    version = "*", 
    opts = {
      open_mapping = [[<c-\>]],
    }
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'hyper',
        config = {
          week_header = {
            enable = true,
          },
          shortcut = {
            { desc = '󰊳  Update', group = '@property', action = 'Lazy update', key = 'u' },
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Files',
              group = 'Label',
              action = 'Telescope find_files',
              key = 'f',
            },
          },
        },
      }
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  }
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


vim.keymap.set('n', '<C-p>', '<CMD>NvimTreeToggle<CR>', {})

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'powerline',
    }
})

require("bufferline").setup({
  options = {
    numbers = "ordinal"
  }
})

-- Kaymapping for bufferline
vim.keymap.set('n', '<leader>1', "<Cmd>BufferLineGoToBuffer 1<CR>", {})
vim.keymap.set('n', '<leader>2', "<Cmd>BufferLineGoToBuffer 2<CR>", {})
vim.keymap.set('n', '<leader>3', "<Cmd>BufferLineGoToBuffer 3<CR>", {})
vim.keymap.set('n', '<leader>4', "<Cmd>BufferLineGoToBuffer 4<CR>", {})
vim.keymap.set('n', '<leader>5', "<Cmd>BufferLineGoToBuffer 5<CR>", {})
vim.keymap.set('n', '<leader>6', "<Cmd>BufferLineGoToBuffer 6<CR>", {})
vim.keymap.set('n', '<leader>7', "<Cmd>BufferLineGoToBuffer 7<CR>", {})
vim.keymap.set('n', '<leader>8', "<Cmd>BufferLineGoToBuffer 8<CR>", {})
vim.keymap.set('n', '<leader>9', "<Cmd>BufferLineGoToBuffer 9<CR>", {})
vim.keymap.set('n', '<leader>$', "<Cmd>BufferLineGoToBuffer -1<CR>", {})

vim.keymap.set('n', '<leader>[b', "<Cmd>BufferLineCycleNext<CR>", {})
vim.keymap.set('n', '<leader>b]', "<Cmd>BufferLineCyclePrev<CR>", {})

require('gitsigns').setup()

-- Setup nvim-cmp.
local cmp = require("cmp")

local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'rust_analyzer',
})

lsp.nvim_workspace()
lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})

-- Colorsheme
vim.cmd.colorscheme "catppuccin"

-- Kaymapping
-- Turn the word under cursor to upper case
vim.keymap.set("i", "<c-u>", "<Esc>viwUea")

-- Turn the current word into title case
vim.keymap.set("i", "<c-t>", "<Esc>b~lea")

vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>fd', vim.lsp.buf.format)
vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help)

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- Optiones
-- [[ Context ]]
-- vim.opt.colorcolumn = '80'           -- str:  Show col for max line length
vim.opt.number = true                -- bool: Show line numbers
vim.opt.relativenumber = true        -- bool: Show relative line numbers
vim.opt.scrolloff = 4                -- int:  Min num lines of context
vim.opt.signcolumn = "yes"           -- str:  Show the sign column

-- [[ Filetypes ]]
vim.opt.encoding = 'utf8'            -- str:  String encoding to use
--- vim.opt.fileencoding = 'utf8'        -- str:  File encoding to use

-- [[ Theme ]]
vim.opt.syntax = "ON"                -- str:  Allow syntax highlighting
vim.opt.termguicolors = true         -- bool: If term supports ui color then enable

-- [[ Search ]]
vim.opt.ignorecase = true            -- bool: Ignore case in search patterns
vim.opt.smartcase = true             -- bool: Override ignorecase if search contains capitals
vim.opt.incsearch = true             -- bool: Use incremental search
vim.opt.hlsearch = false             -- bool: Highlight search matches

-- [[ Whitespace ]]
vim.opt.expandtab = true             -- bool: Use spaces instead of tabs
vim.opt.shiftwidth = 2               -- num:  Size of an indent
vim.opt.softtabstop = 2              -- num:  Number of spaces tabs count for in insert mode
vim.opt.tabstop = 2                  -- num:  Number of spaces tabs count for

-- [[ Splits ]]
vim.opt.splitright = true            -- bool: Place new window to right of current one
vim.opt.splitbelow = true            -- bool: Place new window below the current one

