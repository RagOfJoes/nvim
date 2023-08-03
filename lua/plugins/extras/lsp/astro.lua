return {
	-- Add astro to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			local src = { "astro" }

			vim.list_extend(opts.ensure_installed, src, 1, #src)
		end,
	},

	-- Add astro-language-server to mason
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			local src = {
				"astro-language-server",
			}

			vim.list_extend(opts.ensure_installed, src, 1, #src)
		end,
	},

	-- Correctly setup lspconfig
	{
		"neovim/nvim-lspconfig",
		format = {
			async = true,
		},
		opts = {
			setup = {
				astro = function(_, opts)
					opts.capabilities.documentFormattingProvider = false
				end,
			},
		},
	},
}
