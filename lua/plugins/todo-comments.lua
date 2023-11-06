return {
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
				-- list of highlight groups or use the hex color if hl not found as a fallback
				colors = {
					default = { "Identifier", "#7C3AED" },
					error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
					hint = { "DiagnosticHint", "#10B981" },
					info = { "DiagnosticInfo", "#2563EB" },
					test = { "Identifier", "#FF00FF" },
					warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				},
				gui_style = {
					bg = "BOLD", -- The gui style to use for the bg highlight group.
					fg = "NONE", -- The gui style to use for the fg highlight group.
				},
				highlight = {
					after = "fg", -- "fg" or "bg" or empty
					before = "", -- "fg" or "bg" or empty
					comments_only = true, -- uses treesitter to match keywords in comments only
					exclude = {}, -- list of file types to exclude highlighting
					keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty.
					max_line_len = 400, -- ignore lines longer than this
					multiline = true, -- enable multine todo comments
					multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
					multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
					pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
				},
				keywords = {
					FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
					HACK = { icon = " ", color = "warning" },
					NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
					PERF = { icon = "󰅒", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
					TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
					TODO = { icon = " ", color = "info" },
					WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				},
				merge_keywords = true, -- when true, custom keywords will be merged with the defaults
			}
		end,
	},
}
