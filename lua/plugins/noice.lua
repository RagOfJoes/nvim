return {
	{
		"folke/noice.nvim",
		opts = {
			lsp = {
				documentation = {
					---@type NoiceViewOptions
					opts = {
						win_options = {
							winblend = 10,
							winhighlight = {
								Normal = "NormalFloat",
								FloatBorder = "FloatBorder",
							},
						},
					},
				},
			},
			---@type NoicePresets
			presets = {
				-- Add a border to hover docs and signature help
				lsp_doc_border = true,
			},
		},
	},
}
