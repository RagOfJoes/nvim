-- Change neotree background colors
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		event = "VeryLazy",
		keys = {
			{
				"<leader>fe",
				function()
					require("neo-tree.command").execute({
						dir = require("lazyvim.util").root(),
						toggle = true,
					})
				end,
				desc = "Explorer NeoTree (root dir)",
			},
			{
				"<leader>fE",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
			{
				"<leader>e",
				":Neotree toggle<CR>",
				desc = "Toggle File Explorer",
				silent = true,
			},
			{
				"<leader>E",
				"<leader>fE",
				desc = "Explorer NeoTree (cwd)",
				remap = true,
			},
		},
		config = function()
			require("neo-tree").setup({
				buffers = {
					follow_current_file = {
						enabled = true,
					},
				},
				close_if_last_window = true,
				default_component_configs = {
					git_status = {
						symbols = {
							-- Change type
							added = "",
							deleted = "",
							modified = "",
							renamed = "󰁕",
							-- Status type
							conflict = "",
							ignored = "",
							staged = "",
							unstaged = "󰄱",
							untracked = "",
						},
					},
					icon = {
						folder_closed = "",
						folder_empty = "",
						folder_empty_open = "",
						folder_open = "",
					},
					indent = {
						padding = 0,
						with_markers = false,
						with_expanders = true,
					},
					modified = {
						symbol = " ",
						highlight = "NeoTreeModified",
					},
				},
				enable_diagnostics = false,
				enable_git_status = true,
				enable_modified_markers = true,
				event_handlers = {
					{
						event = "neo_tree_window_after_open",
						handler = function(args)
							if args.position == "left" or args.position == "right" then
								vim.cmd("wincmd =")
							end
						end,
					},
					{
						event = "neo_tree_window_after_close",
						handler = function(args)
							if args.position == "left" or args.position == "right" then
								vim.cmd("wincmd =")
							end
						end,
					},
				},
				filesystem = {
					filtered_items = {
						hide_by_name = {
							"node_modules",
						},
						hide_dotfiles = false,
						hide_gitignored = false,
					},
					follow_current_file = {
						enabled = true,
					},
					use_libuv_file_watcher = true,
				},
				popup_border_style = "rounded",
				sort_case_insensitive = true,
				window = {
					-- position = "float",
					auto_expand_width = false,
					position = "right",
					width = 35,
				},
			})
		end,
	},
}
