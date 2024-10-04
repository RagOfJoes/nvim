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
			if type(opts.ensure_installed) ~= "table" then
				return
			end

			vim.list_extend(opts.ensure_installed, { "astro-language-server" }, 1)
		end,
	},

	-- Correctly setup lspconfig
	{
		"neovim/nvim-lspconfig",
		opts = {
			setup = {
				astro = function(_, opts)
					opts.capabilities.documentFormattingProvider = false
				end,
			},
		},
	},
}
