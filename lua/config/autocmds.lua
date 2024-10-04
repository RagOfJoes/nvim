-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Automatically sets .mdx to have a markdown filetype
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	command = "set filetype=markdown",
	group = vim.api.nvim_create_augroup("MDX", { clear = true }),
	pattern = { "*.mdx" },
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Use Volar's takeover mode in projects that has Vue",
	group = vim.api.nvim_create_augroup("LspAttachConflicts", { clear = true }),
	callback = function(args)
		if not args.data and args.data.client_id then
			return
		end

		local active_clients = vim.lsp.get_active_clients()
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client ~= nil and client.name == "volar" then
			for _, active_client in pairs(active_clients) do
				if active_client.name == "tsserver" then
					active_client.stop()
				end
			end
		elseif client ~= nil and client.name == "tsserver" then
			for _, active_client in pairs(active_clients) do
				-- If volar is active, stop tsserver
				if active_client.name == "volar" then
					active_client.stop()
				end
			end
		end
	end,
})
