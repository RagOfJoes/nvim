return {
	-- Extend auto completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"vuki656/package-info.nvim",
				event = { "BufRead package.json" },
				config = true,
			},
			{
				"David-Kunz/cmp-npm",
				event = { "BufRead package.json" },
				config = true,
			},
		},
		opts = function(_, opts)
			local cmp = require("cmp")
			local src = { { name = "npm", keyword_length = 3 } }

			opts.sources = cmp.config.sources(vim.list_extend(opts.sources, src, 1, #src))
		end,
	},

	-- Add javascript, jsdoc, typescript, and, tsx to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			local src = { "javascript", "jsdoc", "typescript", "tsx" }

			vim.list_extend(opts.ensure_installed, src, 1, #src)
		end,
	},

	-- Add eslint-lsp and typescript-language-server to mason
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			local src = {
				"eslint-lsp",
				"typescript-language-server",
			}

			vim.list_extend(opts.ensure_installed, src, 1, #src)
		end,
	},

	-- Correctly setup lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = { "jose-elias-alvarez/typescript.nvim" },
		format = {
			async = true,
		},
		opts = {
			servers = {
				---@type lspconfig.options.eslint
				eslint = {
					capabilities = {
						documentFormattingProvider = true,
					},
					settings = {
						codeAction = {
							disableRuleComment = {
								enable = true,
								location = "separateLine",
							},
							showDocumentation = {
								enable = true,
							},
						},
						codeActionOnSave = {
							enable = false,
							mode = "all",
						},
						format = true,
						nodePath = "",
						onIgnoredFiles = "off",
						packageManager = "npm",
						quiet = false,
						rulesCustomizations = {},
						run = "onType",
						useESLintClass = false,
						validate = "on",
						-- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
						workingDirectory = {
							mode = "auto",
						},
					},
				},
				tsserver = {
					settings = {
						typescript = {
							format = {
								convertTabsToSpaces = vim.o.expandtab,
								indentSize = vim.o.shiftwidth,
								tabSize = vim.o.tabstop,
							},
						},
						javascript = {
							format = {
								convertTabsToSpaces = vim.o.expandtab,
								indentSize = vim.o.shiftwidth,
								tabSize = vim.o.tabstop,
							},
						},
						completions = {
							completeFunctionCalls = true,
						},
					},
				},
			},
			setup = {
				eslint = function()
					vim.api.nvim_create_autocmd("BufWritePre", {
						callback = function(event)
							local client = vim.lsp.get_active_clients({ bufnr = event.buf, name = "eslint" })[1]
							if client then
								local diag = vim.diagnostic.get(event.buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
								if #diag > 0 then
									vim.cmd("EslintFixAll")
								end
							end
						end,
					})
				end,
				tsserver = function(_, opts)
					require("lazyvim.util").on_attach(function(client, buffer)
						if client.name == "tsserver" then
              -- stylua: ignore
              vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
							vim.keymap.set(
								"n",
								"<leader>cR",
								"<cmd>TypescriptRenameFile<CR>",
								{ desc = "Rename File", buffer = buffer }
							)
						end
					end)

					opts.capabilities.documentFormattingProvider = false
				end,
			},
		},
	},
}
