return {
	-- Add go to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			local src = { "go", "gomod" }

			vim.list_extend(opts.ensure_installed, src, 1, #src)
		end,
	},

	-- Add goimports and gopls to mason
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			local src = {
				"goimports",
				"gopls",
			}

			vim.list_extend(opts.ensure_installed, src, 1, #src)
		end,
	},

	-- Correctly setup lspconfig
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				gopls = {},
			},
		},
	},
}
