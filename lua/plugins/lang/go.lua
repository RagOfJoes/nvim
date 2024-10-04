return {
	-- Add go to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			local src = { "go", "gomod", "gosum", "gowork" }

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
				gopls = {
					analyses = {
						fieldalignment = true,
						nilness = true,
						unusedparams = true,
						unusedwrite = true,
						useany = true,
					},
					codelenses = {
						gc_details = false,
						generate = true,
						regenerate_cgo = true,
						run_govulncheck = true,
						test = true,
						tidy = true,
						upgrade_dependency = true,
						vendor = true,
					},
					completeUnimported = true,
					directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
					gofumpt = true,
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
					semanticTokens = true,
					staticcheck = true,
					usePlaceholders = true,
				},
			},
			setup = {
				gopls = function()
					-- workaround for gopls not supporting semanticTokensProvider
					-- https://github.com/golang/go/issues/54531#issuecomment-1464982242
					require("lazyvim.util").lsp.on_attach(function(client, _)
						if client.name == "gopls" then
							if not client.server_capabilities.semanticTokensProvider then
								local semantic = client.config.capabilities.textDocument.semanticTokens
								client.server_capabilities.semanticTokensProvider = {
									full = true,
									legend = {
										tokenTypes = semantic.tokenTypes,
										tokenModifiers = semantic.tokenModifiers,
									},
									range = true,
								}
							end
						end
					end)
					-- end workaround
				end,
			},
		},
	},

	-- Correctly setup none-ls
	{
		"nvimtools/none-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.sources = vim.list_extend(opts.sources or {}, {
				nls.builtins.code_actions.gomodifytags,
				nls.builtins.code_actions.impl,
				nls.builtins.formatting.goimports,
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				go = { "goimports" },
			},
		},
	},
}
