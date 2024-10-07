return {
	jsonls = {
		settings = {
			json = {
				schema = require('schemastore').json.schemas(),
				validate = { enable = true },
			},
		},
	},
	terraformls = {
		cmd = { 'terraform-ls' },
		arg = { 'server' },
		filetypes = { 'terraform', 'tf', 'terraform-vars' },
	},
	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = 'LuaJIT' },
				workspace = {
					checkThirdParty = false,
					library = {
						'${3rd}/luv/library',
						unpack(vim.api.nvim_get_runtime_file('', true)),
					},
				},
				completion = {
					callSnippet = 'Replace',
				},
			},
		},
	},
	bashls = {
		filetypes = { 'sh', 'zsh' },
	},
	vimls = {
		filetypes = { 'vim' },
	},
	-- tsserver = {},
	-- ts_ls = {},
	gopls = {},
	eslint = {
		capabilities = {
			documentFormattingProvider = true,
		},
		settings = {
			codeAction = {
				disableRuleComment = {
					enable = true,
					location = 'separateLine',
				},
				showDocumentation = {
					enable = true,
				},
			},
			codeActionOnSave = {
				enable = false,
				mode = 'all',
			},
			format = true,
			nodePath = '',
			onIgnoredFiles = 'off',
			packageManager = 'npm',
			quiet = false,
			rulesCustomizations = {},
			run = 'onType',
			useESLintClass = false,
			validate = 'on',
			-- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
			workingDirectory = {
				mode = 'auto',
			},
		},
	},
	ts_ls = {
		-- keys = {
		--   {
		--     "<leader>co",
		--     function()
		--       vim.lsp.buf.code_action({
		--         apply = true,
		--         context = {
		--           only = { "source.organizeImports.ts" },
		--           diagnostics = {},
		--         },
		--       })
		--     end,
		--     desc = "Organize Imports",
		--   },
		-- },
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
	pyright = {},

	solidity_ls_nomicfoundation = {},
	yamlls = {
		cmd = { 'yaml-language-server', '--stdio' },
		filetypes = { 'yaml' },
	},

	zls = {},
	clangd = {},
	marksman = {},
	-- "markdownlint-cli2", "markdown-toc"
}
