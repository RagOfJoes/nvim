local M = {}

M.on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true }
	-- local map = vim.keymap.set

	-- Keep cursor centered when scrolling
	vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
	vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

	-- Move selected line / block of text in visual mode
	vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
	vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

	-- Fast saving
	-- vim.keymap.set("n", "<leader>w", ":write!<CR>", { silent = true, desc = "Save file" })
	-- vim.keymap.set("n", "<leader>q", ":q!<CR>", opts)

	-- Remap for dealing with visual line wraps
	vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
	vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

	-- better indenting
	vim.keymap.set('v', '<', '<gv')
	vim.keymap.set('v', '>', '>gv')

	-- paste over currently selected text without yanking it
	vim.keymap.set('v', 'p', '"_dp')
	vim.keymap.set('v', 'P', '"_dP')

	-- copy everything between { and } including the brackets
	-- p puts text after the cursor,
	-- P puts text before the cursor.
	vim.keymap.set('n', 'YY', 'va{Vy', opts)

	-- Move line on the screen rather than by line in the file
	vim.keymap.set('n', 'j', 'gj', opts)
	vim.keymap.set('n', 'k', 'gk', opts)

	-- Exit on jj and jk
	vim.keymap.set('i', 'jj', '<ESC>', opts)
	vim.keymap.set('i', 'jk', '<ESC>', opts)

	-- Move to start/end of line
end

return M
