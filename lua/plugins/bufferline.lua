local colors = require("config.colors").colors

return {
	{
		"akinsho/bufferline.nvim",
		-- enabled = false,
		opts = {
			highlights = {
				background = {
					bg = "",
				},
				buffer_visible = {
					bg = "",
				},
				close_button = {
					bg = "",
					fg = colors.fg,
				},
				close_button_visible = {
					bg = "",
					fg = colors.fg,
				},
				close_button_selected = {
					fg = {
						attribute = "fg",
						highlight = "StatusLineNonText",
					},
				},
				duplicate = {
					bg = "",
					fg = colors.fg,
				},
				duplicate_visible = {
					bg = "",
					fg = colors.fg,
				},
				fill = {
					bg = "",
				},
				modified = {
					bg = "",
				},
				modified_visible = {
					bg = "",
				},
				offset_separator = {
					bg = "",
					fg = colors.bg,
				},
				tab = {
					bg = "",
				},
				tab_close = {
					bg = "",
				},
				tab_separator = {
					fg = colors.bg,
					bg = "",
				},
				tab_separator_selected = {
					bg = "",
					fg = colors.bg,
					sp = colors.fg,
				},
				separator = {
					bg = "",
					fg = colors.bg,
				},
				separator_selected = {
					bg = "",
					fg = colors.bg,
				},
				separator_visible = {
					bg = "",
					fg = colors.bg,
				},
			},
			options = {
				always_show_bufferline = true,
				custom_areas = {
					left = function()
						if vim.bo.filetype == "alpha" then
							return {}
						end

						return {
							{ text = "    ", fg = colors.fg },
						}
					end,
				},
				indicator = {
					icon = " ",
				},
				max_name_length = 25,
				modified_icon = "",
				offsets = {
					{
						filetype = "neo-tree",
						highlight = "Directory",
						separator = "|",
						text = "  Project",
						text_align = "left",
					},
				},
				show_buffer_close_icons = false,
				show_close_icon = false,
				show_tab_indicators = false,
				tab_size = 0,
			},
		},
	},
}
