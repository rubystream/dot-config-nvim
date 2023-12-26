
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
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

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

-- Colorsheme
vim.cmd.colorscheme "catppuccin"

-- Optiones
vim.opt.number = true
vim.opt.relativenumber = true
