local util = require("lspconfig.util")

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

	-- Add javascript, jsdoc, typescript, tsx, and vue to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			local src = { "javascript", "jsdoc", "typescript", "tsx", "vue" }

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
				"vue-language-server",
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
					keys = {
						{
							"<leader>co",
							function()
								vim.lsp.buf.code_action({
									apply = true,
									context = {
										only = { "source.organizeImports.ts" },
										diagnostics = {},
									},
								})
							end,
							desc = "Organize Imports",
						},
					},
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
				volar = {
					-- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
					on_new_config = function(new_config, new_root_dir)
						-- Global typescript path for pnpm on macOS
						local global_ts = "~/Library/pnpm/global/5/node_modules/typescript/lib"

						local local_ts = ""
						local found_ts = ""
						local function check_dir(path)
							found_ts = util.path.join(path, "node_modules", "typescript", "lib")
							if util.path.exists(found_ts) then
								return path
							end
						end

						if util.search_ancestors(new_root_dir, check_dir) then
							local_ts = found_ts
						else
							local_ts = global_ts
						end

						new_config.init_options.typescript.tsdk = local_ts
					end,
				},
			},
			setup = {
				eslint = function()
					local function get_client(buf)
						return require("lazyvim.util").lsp.get_clients({ name = "eslint", bufnr = buf })[1]
					end

					local formatter = require("lazyvim.util").lsp.formatter({
						filter = "eslint",
						name = "eslint: lsp",
						primary = false,
						priority = 200,
					})

					-- Use EslintFixAll on Neovim < 0.10.0
					if not pcall(require, "vim.lsp._dynamic") then
						formatter.name = "eslint: EslintFixAll"
						formatter.sources = function(buf)
							local client = get_client(buf)
							return client and { "eslint" } or {}
						end
						formatter.format = function(buf)
							local client = get_client(buf)
							if client then
								local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
								if #diag > 0 then
									vim.cmd("EslintFixAll")
								end
							end
						end
					end

					-- register the formatter with LazyVim
					require("lazyvim.util").format.register(formatter)
				end,
			},
		},
	},
}
