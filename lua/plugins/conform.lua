return {
	'stevearc/conform.nvim',
	event = { 'BufWritePre' },
	cmd = { 'ConformInfo' },
	keys = {
		{
			'<leader>cf',
			function()
				require('conform').format({ async = true }, function(err, did_edit)
					if not err and did_edit then
						vim.notify('Code formatted', vim.log.levels.INFO, { title = 'Conform' })
					end
				end)
			end,
			mode = { 'n', 'v' },
			desc = 'Format buffer',
		},
	},
	opts = {
		formatters_by_ft = {
			-- Go
			go = { 'goimports', 'gofmt' },

			-- Lua
			lua = { 'stylua' },

			-- Web technologies
			astro = { 'prettierd', 'prettier' },
			javascript = { 'prettierd', 'prettier' },
			typescript = { 'prettierd', 'prettier' },
			javascriptreact = { 'prettierd', 'prettier' },
			typescriptreact = { 'prettierd', 'prettier' },
			json = { 'prettierd', 'prettier' },
			jsonc = { 'prettierd', 'prettier' },
			yaml = { 'prettierd', 'prettier' },
			markdown = { 'prettierd', 'prettier' },
			html = { 'prettierd', 'prettier' },
			css = { 'prettierd', 'prettier' },
			scss = { 'prettierd', 'prettier' },

			-- Python
			python = { 'isort', 'black' },

			-- Shell
			sh = { 'shfmt' },
			bash = { 'shfmt' },

			-- Other (system tools)
			rust = { 'rustfmt' }, -- comes with Rust installation

			-- Additional file types (uncomment as needed)
			-- markdown = { "markdownlint" },
			-- yaml = { "yamllint" },
			-- toml = { "taplo" },
		},
		default_format_opts = {
			lsp_format = 'fallback',
		},
		format_on_save = {
		    timeout_ms = 1000,
		    lsp_format = "fallback",
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
