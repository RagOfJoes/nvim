return {
	'mfussenegger/nvim-lint',
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		local lint = require 'lint'

		-- Configure custom linters using Mason-managed tools
		-- local mason_bin_dir = vim.fn.stdpath 'data' .. '/mason/bin'

		-- Customize eslint_d
		local function find_eslint_root()
			local config_files = {
				'eslint.config.js',
				'eslint.config.cjs',
				'eslint.config.mjs',
				'eslint.config.ts',
				'.eslintrc.js',
				'.eslintrc.cjs',
				'.eslintrc.json',
				'.eslintrc',
			}

			return vim.fs.dirname(vim.fs.find(config_files, {
				upward = true,
				stop = vim.loop.os_homedir(),
				path = vim.fn.expand '%:p:h',
			})[1])
		end

		local eslint_d = lint.linters.eslint_d
		eslint_d.cwd = find_eslint_root
		vim.tbl_extend('force', {
			codeAction = {
				disableRuleComment = {
					enable = true,
					location = 'separateLine',
				},
				showDocumentation = {
					enable = true,
				},
			},
		}, eslint_d.settings or {})

		-- Customize golangcilint to ignore exit codes (golangci-lint exits with code 1-3 when issues are found)
		local golangcilint = lint.linters.golangcilint
		golangcilint.ignore_exitcode = true

		-- Configure linters by filetype (using Mason-managed tools)
		lint.linters_by_ft = {
			-- Go
			go = { 'golangcilint' },

			-- JavaScript/TypeScript
			astro = { 'eslint_d' },
			javascript = { 'eslint_d' },
			typescript = { 'eslint_d' },
			javascriptreact = { 'eslint_d' },
			typescriptreact = { 'eslint_d' },

			-- Lua
			lua = { 'luacheck' },

			-- Shell
			sh = { 'shellcheck' },
			bash = { 'shellcheck' },
			zsh = { 'shellcheck' },

			-- You can add more linters here as needed
			-- python = { 'flake8', 'mypy' },
			rust = { 'clippy' },
		}

		-- Auto-lint on save and text changes
		local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
		vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
			group = lint_augroup,
			callback = function(args)
				local opts = { ignore_errors = args.event ~= 'BufWritePost' }

				local clients = vim.lsp.get_clients { bufnr = 0 }
				local key, client = next(clients)
				while key do
					if client ~= nil then
						if client.workspace_folders then
							for _, dir in pairs(client.workspace_folders) do
								if vim.fs.relpath(dir.name, vim.api.nvim_buf_get_name(0)) then
									opts.cwd = dir.name
								end
							end
						elseif client.root_dir then
							opts.cwd = client.root_dir
						end
						if opts.cwd then
							break
						end
						key, client = next(clients, key)
					end
				end

				lint.try_lint(nil, opts)
			end,
		})
		-- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
		-- 	group = lint_augroup,
		-- 	callback = function()
		-- 		-- Only lint if linters are available for this filetype
		-- 		local linters = lint.linters_by_ft[vim.bo.filetype]
		-- 		if linters and #linters > 0 then
		-- 			lint.try_lint()
		-- 		end
		-- 	end,
		-- })

		-- Manual linting command
		vim.keymap.set('n', '<leader>ll', function()
			lint.try_lint()
			vim.notify('Linting...', vim.log.levels.INFO, { title = 'nvim-lint' })
		end, { desc = 'Trigger linting for current file' })

		-- Show linter status
		vim.keymap.set('n', '<leader>li', function()
			local linters = lint.linters_by_ft[vim.bo.filetype] or {}
			if #linters == 0 then
				print('No linters configured for filetype: ' .. vim.bo.filetype)
			else
				print('Linters for ' .. vim.bo.filetype .. ': ' .. table.concat(linters, ', '))
			end
		end, { desc = 'Show available linters for current filetype' })
	end,
}
