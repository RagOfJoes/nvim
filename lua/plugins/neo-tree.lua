return {
	'nvim-neo-tree/neo-tree.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',
		'MunifTanjim/nui.nvim',
	},
	event = 'VeryLazy',
	keys = {
		{ '<leader>e', ':Neotree toggle float<CR>', silent = true, desc = 'Float File Explorer' },
		{ '<leader><Tab>', ':Neotree toggle right<CR>', silent = true, desc = 'Right File Explorer' },
	},
	config = function()
		require('neo-tree').setup {
			close_if_last_window = true,
			enable_diagnostics = true,
			enable_git_status = true,
			enable_modified_markers = true,
			popup_border_style = 'single',
			sort_case_insensitive = true,
			default_component_configs = {
				indent = {
					with_markers = true,
					with_expanders = true,
				},
				modified = {
					symbol = ' ',
					highlight = 'NeoTreeModified',
				},
				icon = {
					folder_closed = '',
					folder_open = '',
					folder_empty = '',
					folder_empty_open = '',
				},
				git_status = {
					symbols = {
						-- Change type
						added = '',
						deleted = '',
						modified = '',
						renamed = '',
						-- Status type
						conflict = '',
						ignored = '',
						staged = '',
						unstaged = '',
						untracked = '',
					},
				},
			},
			window = {
				position = 'float',
				width = 35,
			},
			filesystem = {
				use_libuv_file_watcher = true,
				filtered_items = {
					hide_by_name = {
						'node_modules',
					},
					hide_dotfiles = false,
					hide_gitignored = false,
					never_show = {
						'.DS_Store',
						'thumbs.db',
					},
				},
			},
			source_selector = {
				winbar = true,
				sources = {
					{ source = 'filesystem', display_name = '   Files ' },
					{ source = 'buffers', display_name = '   Bufs ' },
					{ source = 'git_status', display_name = '   Git ' },
				},
			},
			event_handlers = {
				{
					event = 'neo_tree_window_after_open',
					handler = function(args)
						if args.position == 'left' or args.position == 'right' then
							vim.cmd 'wincmd ='
						end
					end,
				},
				{
					event = 'neo_tree_window_after_close',
					handler = function(args)
						if args.position == 'left' or args.position == 'right' then
							vim.cmd 'wincmd ='
						end
					end,
				},
			},
		}
	end,
}
