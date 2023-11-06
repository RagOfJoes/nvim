return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					auto_refresh = true,
					enabled = true,
					keymap = {
						accept = "<c-a>",
						jump_next = "<c-j>",
						jump_prev = "<c-k>",
						open = "<M-CR>",
						refresh = "r",
					},
					layout = {
						position = "bottom", -- | top | left | right
						ratio = 0.4,
					},
				},
				suggestion = {
					auto_trigger = true,
					debounce = 75,
					enabled = true,
					keymap = {
						accept = "<c-a>",
						accept_word = false,
						accept_line = false,
						next = "<c-j>",
						prev = "<c-k>",
						dismiss = "<C-e>",
					},
				},
			})
		end,
	},
}
