return {
	-- Language specific extension modules
	{ import = "plugins.extras.lsp.astro" },
	{ import = "plugins.extras.lsp.c" },
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
		"nvimtools/none-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.sources = opts.sources or {}
			table.insert(opts.sources, nls.builtins.formatting.prettierd)
		end,
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				["css"] = { { "prettierd", "prettier" } },
				["graphql"] = { { "prettierd", "prettier" } },
				["handlebars"] = { { "prettierd", "prettier" } },
				["html"] = { { "prettierd", "prettier" } },
				["javascript"] = { { "prettierd", "prettier" } },
				["javascriptreact"] = { { "prettierd", "prettier" } },
				["json"] = { { "prettierd", "prettier" } },
				["jsonc"] = { { "prettierd", "prettier" } },
				["less"] = { { "prettierd", "prettier" } },
				["markdown"] = { { "prettierd", "prettier" } },
				["markdown.mdx"] = { { "prettierd", "prettier" } },
				["scss"] = { { "prettierd", "prettier" } },
				["typescript"] = { { "prettierd", "prettier" } },
				["typescriptreact"] = { { "prettierd", "prettier" } },
				["vue"] = { { "prettierd", "prettier" } },
				["yaml"] = { { "prettierd", "prettier" } },
			},
		},
	},
}
