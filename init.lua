
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
		"folke/which-key.nvim"
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

require("bufferline").setup({})
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

