local status_ok, which_key = pcall(require, 'which-key')
if not status_ok then
	return
end

local opts = {
	mode = 'n',
	prefix = '<leader>',
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
}

which_key.add {
	{ '<leader>gc', ':GoCmt<CR>', desc = 'Go: Comment', opts },
	{ '<leader>tf', ':GoTestFile<CR>', desc = 'Go: Test File', opts },
	{ '<leader>tm', ':GoTestFunc<CR>', desc = 'Go: Test Function', opts },
}
