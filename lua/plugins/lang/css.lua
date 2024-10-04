return {
	-- Extend auto completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
		},
		opts = function(_, opts)
			-- original LazyVim kind icon formatter
			local format_kinds = opts.formatting.format
			opts.formatting.format = function(entry, item)
				format_kinds(entry, item) -- add icons
				return require("tailwindcss-colorizer-cmp").formatter(entry, item)
			end
		end,
	},

	-- Add css and scss to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			local src = { "css", "scss" }

			vim.list_extend(opts.ensure_installed, src, 1, #src)
		end,
	},

	-- Add css-lsp, stylelint-lsp, and, tailwindcss-language-server to mason
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			local src = {
				"css-lsp",
				"stylelint-lsp",
				"tailwindcss-language-server",
			}

			vim.list_extend(opts.ensure_installed, src, 1, #src)
		end,
	},

	-- Correctly setup lspconfig
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				cssls = {},
				tailwindcss = {
					filetypes_exclude = { "markdown" },
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = {
									{ "clsx\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
									{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
								},
							},
						},
					},
				},
			},
			setup = {
				tailwindcss = function(_, opts)
					local tw = require("lspconfig.server_configurations.tailwindcss")
					--- @param ft string
					opts.filetypes = vim.tbl_filter(function(ft)
						return not vim.tbl_contains(opts.filetypes_exclude, ft)
					end, tw.default_config.filetypes)
				end,
			},
		},
	},
}
