local colors = require("config.colors").colors

return {
	{
		"goolord/alpha-nvim",
		opts = function(_, opts)
			--   8 Face
			--   local logo = [[
			--      █████╗ ██╗
			--     ██╔══██╗╚██╗
			--     ╚█████╔╝ ██║
			--     ██╔══██╗ ██║
			--     ╚█████╔╝██╔╝
			--      ╚════╝ ╚═╝
			-- ]]

			-- Pacman
			-- local logo = {
			--   [[                                    ██████                                    ]],
			--   [[                                ████▒▒▒▒▒▒████                                ]],
			--   [[                              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                              ]],
			--   [[                            ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                            ]],
			--   [[                          ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒                              ]],
			--   [[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓                          ]],
			--   [[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓                          ]],
			--   [[                        ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██                        ]],
			--   [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
			--   [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
			--   [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
			--   [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
			--   [[                        ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██                        ]],
			--   [[                        ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██                        ]],
			--   [[                        ██      ██      ████      ████                        ]],
			-- }

			-- Gojo
			local logo = {
				[[ ⣿⣿⣿⣿⣿⣿⣿⡿⣿⣫⢿⣿⡿⣡⡏⣽⣿⣿⣿⣿⣿⣿⣿ ]],
				[[ ⣿⣿⣿⣿⣿⣿⣿⡇⣧⡏⢼⣫⣖⣛⣙⣛⡿⢿⣿⣿⣿⣿⣿ ]],
				[[ ⣿⣿⣿⡿⣻⡭⣭⣅⣹⣷⣿⣿⡯⠽⣛⣻⢿⣐⣪⠭⠭⢿⣿ ]],
				[[ ⣿⣿⡯⢞⣫⣾⣹⣿⣿⣿⣿⣿⡿⣟⣦⡹⣿⣷⡾⣴⣚⠿⠿ ]],
				[[ ⣷⣶⣿⠏⣿⣿⣿⣿⢿⣿⡏⠹⡟⣟⡞⢿⡽⠨⠩⡢⢱⣶⣿ ]],
				[[ ⡟⢋⣤⢸⣿⣯⣿⢻⠞⡸⣇⡇⡇⢸⣽⢢⣳⡈⡔⡑⢣⢿⣿ ]],
				[[ ⣿⣿⡏⠣⣧⢿⡞⣏⣌⠱⡽⠠⢱⣧⠓⢪⠷⠃⣝⣆⢠⣸⣿ ]],
				[[ ⣿⣟⡴⡀⡌⡃⠻⠹⠙⠎⠀⠀⠀⠈⣓⠀⠀⠀⠀⣮⣊⣿⣿ ]],
				[[ ⣿⣿⣿⢣⡖⠐⡢⢿⣾⣿⣦⣤⣤⣼⣿⣷⣤⣤⢀⣿⣿⣿⣿ ]],
				[[ ⣿⣿⣿⣿⣿⠀⣝⢾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣿⣿⣿⣿ ]],
				[[ ⣿⣿⣿⣿⡿⠿⢸⣿⣮⣿⣿⣿⣿⣯⡻⣻⡿⢃⣼⣿⣿⣿⣿ ]],
				[[ ⣿⣿⣿⣿⡇⠀⠈⠛⠿⣷⣍⢛⠿⠿⣿⢏⣴⣿⣿⣿⣿⣿⣿ ]],
				[[ ⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠉⠛⠦⠈⠺⢿⣿⣿⣿⣿⣿⣿⣿ ]],
				[[ ⣿⣿⡿⠁⠀⠀⠀⠀⠄⡀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿ ]],
				[[ ⣿⢟⣠⣾⣦⣠⣤⣤⡀⠀⠁⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿ ]],
			}

			-- opts.section.header.val = vim.split(logo, "\n", { trimpempty = true })
			opts.section.header.val = logo
		end,
	},

	{
		"akinsho/bufferline.nvim",
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
					fg = { attribute = "fg", highlight = "StatusLineNonText" },
				},
				duplicate = {
					fg = colors.fg,
					bg = "",
				},
				duplicate_visible = {
					fg = colors.fg,
					bg = "",
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
					fg = colors.bg,
					bg = "",
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
					fg = colors.bg,
					bg = "",
					sp = colors.fg,
				},
				separator = {
					fg = colors.bg,
					bg = "",
				},
				separator_selected = {
					fg = colors.bg,
					bg = "",
				},
				separator_visible = {
					fg = colors.bg,
					bg = "",
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
				show_close_icon = false,
				tab_size = 0,
			},
		},
	},

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
				theme = {
					command = {
						a = { fg = colors.fg, bg = colors.bg },
						b = { fg = colors.fg, bg = colors.bg },
					},
					insert = {
						a = { fg = colors.fg, bg = colors.bg },
						b = { fg = colors.fg, bg = colors.bg },
					},
					replace = {
						a = { fg = colors.fg, bg = colors.bg },
						b = { fg = colors.fg, bg = colors.bg },
					},
					visual = {
						a = { fg = colors.fg, bg = colors.bg },
						b = { fg = colors.fg, bg = colors.bg },
					},
					normal = {
						a = { fg = colors.fg, bg = colors.bg },
						b = { fg = colors.fg, bg = colors.bg },
						c = { fg = colors.fg, bg = colors.bg },
					},

					inactive = {
						a = { bg = colors.fg, fg = colors.bg },
						b = { bg = colors.fg, fg = colors.bg },
						c = { bg = colors.fg, fg = colors.bg },
					},
				},
			},
			sections = {
				lualine_a = {},
				lualine_b = { "branch" },
				lualine_c = {
					-- "filename",
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
				},
				lualine_x = { "encoding" },
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

	{
		"folke/noice.nvim",
		opts = {
			lsp = {
				documentation = {
					---@type NoiceViewOptions
					opts = {
						win_options = {
							winblend = 15,
							winhighlight = {
								Normal = "NormalFloat",
								FloatBorder = "FloatBorder",
							},
						},
					},
				},
			},
			---@type NoicePresets
			presets = {
				-- Add a border to hover docs and signature help
				lsp_doc_border = true,
			},
		},
	},

	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				tailwind = true,
			},
		},
	},
}
