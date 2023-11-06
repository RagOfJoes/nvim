local colors = require("config.colors").colors

local function diff_source()
	---@diagnostic disable-next-line: undefined-field
	local gitsigns = vim.b.gitsigns_status_dict

	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local theme = {
	command = {
		a = { fg = colors.fg, bg = colors.bg },
		b = { fg = colors.fg, bg = colors.bg },
	},
	inactive = {
		a = { bg = colors.fg, fg = colors.bg },
		b = { bg = colors.fg, fg = colors.bg },
		c = { bg = colors.fg, fg = colors.bg },
	},
	insert = {
		a = { fg = colors.fg, bg = colors.bg },
		b = { fg = colors.fg, bg = colors.bg },
	},
	normal = {
		a = { fg = colors.fg, bg = colors.bg },
		b = { fg = colors.fg, bg = colors.bg },
		c = { fg = colors.fg, bg = colors.bg },
	},
	replace = {
		a = { fg = colors.fg, bg = colors.bg },
		b = { fg = colors.fg, bg = colors.bg },
	},
	visual = {
		a = { fg = colors.fg, bg = colors.bg },
		b = { fg = colors.fg, bg = colors.bg },
	},
}

return {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				component_separators = "",
				disabled_filetypes = {
					statusline = {
						"help",
						"startify",
						"dashboard",
						"neo-tree",
						"packer",
						"neogitstatus",
						"NvimTree",
						"Trouble",
						"alpha",
						"lir",
						"Outline",
						"spectre_panel",
						"toggleterm",
						"qf",
					},
					winbar = {},
				},
				icons_enabled = true,
				section_separators = "",
				theme = theme,
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						"filetype",
						icon_only = true,
						padding = {
							left = 1,
							right = 0,
						},
						separator = "",
					},
					{
						"filename",
						path = 1,
						symbols = {
							modified = "  ",
							readonly = "",
							unnamed = "",
						},
					},
					{
						"diagnostics",
						sources = { "nvim_lsp" },
						symbols = { error = " ", info = " ", warn = " " },
					},
					{
						"diff",
						source = diff_source(),
					},
					{ "searchcount" },
				},
				lualine_x = {
					{ "b:gitsigns_head", icon = "" },
				},
				lualine_y = { "progress" },
				lualine_z = {
					function()
						return " " .. os.date("%R")
					end,
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "neo-tree", "lazy" },
		},
	},
}
