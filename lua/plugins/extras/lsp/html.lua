return {
	-- Add html to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			local src = { "html" }

			vim.list_extend(opts.ensure_installed, src, 1, #src)
		end,
	},

	-- Add html-lsp to mason
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			local src = {
				"html-lsp",
			}

			vim.list_extend(opts.ensure_installed, src, 1, #src)
		end,
	},

	-- Correctly setup lspconfig
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				html = {},
			},
		},
	},
}
