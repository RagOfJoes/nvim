return {
	-- Language specific extension modules
	{ import = "plugins.extras.lsp.astro" },
	{ import = "plugins.extras.lsp.css" },
	{ import = "plugins.extras.lsp.go" },
	{ import = "plugins.extras.lsp.html" },
	{ import = "plugins.extras.lsp.php" },
	{ import = "plugins.extras.lsp.rust" },
	{ import = "plugins.extras.lsp.typescript" },
	{ import = "lazyvim.plugins.extras.lang.json" },

	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			local src = {
				"prettierd",
			}

			vim.list_extend(opts.ensure_installed, src, 1, #src)
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufNewFile", "BufReadPre" },
		dependencies = { "mason.nvim" },
		opts = function()
			local nls = require("null-ls")

			return {
				sources = {
					nls.builtins.diagnostics.phpcs.with({
						extra_args = {
							"--config-set",
							"report_width",
							"120",
						},
					}),

					nls.builtins.formatting.gofmt,
					nls.builtins.formatting.goimports,
					nls.builtins.formatting.nginx_beautifier,
					nls.builtins.formatting.prettierd.with({
						extra_filetypes = {
							"astro",
						},
					}),
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.terraform_fmt,
				},
			}
		end,
	},
}
