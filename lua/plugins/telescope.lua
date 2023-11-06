local actions = require("telescope.actions")

return {
	{
		"nvim-telescope/telescope.nvim",
		opts = {
			defaults = {
				layout_config = {
					preview_cutoff = 120,
					prompt_position = "top",
				},
			},
			pickers = {
				buffers = {
					initial_mode = "insert",
					layout_config = {
						width = 0.5,
						height = 0.4,
						prompt_position = "top",
						preview_cutoff = 120,
					},
					mappings = {
						i = {
							["<c-d>"] = actions.delete_buffer,
						},
						n = {
							["<c-d>"] = actions.delete_buffer,
						},
					},
					previewer = false,
					theme = "dropdown",
				},
			},
		},
	},
}
