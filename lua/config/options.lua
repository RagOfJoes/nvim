vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0
vim.opt.fileencoding = "utf-8"
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.expandtab = true
vim.opt.linebreak = true
vim.opt.guifont = "monospace:h17"
vim.opt.shiftwidth = 2
vim.opt.showtabline = 0
vim.opt.signcolumn = "yes"
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.title = true

-- Enable fold for nvim-ufo
-- vim.opt.foldenable = true
-- Set high foldlevel for nvim-ufo
-- vim.opt.foldlevel = 99
-- Start with all code unfolded
-- vim.opt.foldlevelstart = 99
-- Show foldcolumn in nvim 0.9
-- vim.opt.foldcolumn = vim.fn.has("nvim-0.9") == 1 and "1" or nil

vim.opt.list = true
vim.opt.listchars = {
	-- eol = "",
	extends = "⟩",
	-- nbsp = "␣",
	precedes = "⟨",
	tab = " ",
	trail = ".",
}
vim.opt.showbreak = " "
-- vim.opt.listchars = { tab = " ", extends = "⟩", precedes = "⟨", trail = "·" }

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.termguicolors = true

vim.opt.wrap = true
