-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Automatically sets .mdx to have a markdown filetype
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	command = "set filetype=markdown",
	group = vim.api.nvim_create_augroup("MDX", { clear = true }),
	pattern = { "*.mdx" },
})
