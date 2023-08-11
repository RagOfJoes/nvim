return {
	-- change neotree background colors
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
					require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
				end,
				desc = "Explorer NeoTree (root dir)",
				silent = true,
			},
			{
				"<leader>fE",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
				silent = true,
			},
			{
				"<leader>e",
				":Neotree toggle float<CR>",
				desc = "Float File Explorer",
				remap = true,
				silent = true,
			},
			{
				"<leader>E",
				"<leader>fE",
				desc = "Explorer NeoTree (cwd)",
				remap = true,
				silent = true,
			},
		},
		config = function()
			require("neo-tree").setup({
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
					},
					follow_current_file = {
						enabled = true,
					},
					use_libuv_file_watcher = true,
				},
				popup_border_style = "rounded",
				sort_case_insensitive = true,
				window = {
					position = "float",
					width = 35,
				},
			})
		end,
	},

	{
		"kevinhwang91/nvim-ufo",
		event = { "InsertEnter" },
		dependencies = { "kevinhwang91/promise-async" },
		opts = {
			preview = {
				mappings = {
					scrollB = "<C-b>",
					scrollF = "<C-f>",
					scrollU = "<C-u>",
					scrollD = "<C-d>",
				},
			},
			provider_selector = function(_, filetype, buftype)
				local function handleFallbackException(bufnr, err, providerName)
					if type(err) == "string" and err:match("UfoFallbackException") then
						return require("ufo").getFolds(bufnr, providerName)
					else
						return require("promise").reject(err)
					end
				end

				return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
					or function(bufnr)
						return require("ufo")
							.getFolds(bufnr, "lsp")
							:catch(function(err)
								return handleFallbackException(bufnr, err, "treesitter")
							end)
							:catch(function(err)
								return handleFallbackException(bufnr, err, "indent")
							end)
					end
			end,
		},
	},

	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TodoTrouble", "TodoTelescope" },
		config = true,
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},
			{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
			{ "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
			{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
			{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
		},
		opts = function()
			return {
				keywords = {
					FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
					TODO = { icon = " ", color = "info" },
					HACK = { icon = " ", color = "warning" },
					WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
					PERF = { icon = "󰅒", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
					NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
					TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				},
				gui_style = {
					fg = "NONE", -- The gui style to use for the fg highlight group.
					bg = "BOLD", -- The gui style to use for the bg highlight group.
				},
				merge_keywords = true, -- when true, custom keywords will be merged with the defaults
				highlight = {
					multiline = true, -- enable multine todo comments
					multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
					multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
					before = "", -- "fg" or "bg" or empty
					keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty.
					after = "fg", -- "fg" or "bg" or empty
					pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
					comments_only = true, -- uses treesitter to match keywords in comments only
					max_line_len = 400, -- ignore lines longer than this
					exclude = {}, -- list of file types to exclude highlighting
				},
				-- list of highlight groups or use the hex color if hl not found as a fallback
				colors = {
					error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
					warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
					info = { "DiagnosticInfo", "#2563EB" },
					hint = { "DiagnosticHint", "#10B981" },
					default = { "Identifier", "#7C3AED" },
					test = { "Identifier", "#FF00FF" },
				},
			}
		end,
	},

	{
		"folke/trouble.nvim",
		opts = {
			use_diagnostic_signs = true,
		},
	},
}
