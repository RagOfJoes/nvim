return {
	-- Extend auto completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"Saecki/crates.nvim",
				event = { "BufRead Cargo.toml" },
				config = true,
			},
		},
		opts = function(_, opts)
			local cmp = require("cmp")
			local src = { { name = "crates" } }

			opts.sources = cmp.config.sources(vim.list_extend(opts.sources, src, 1, #src))
		end,
	},

	-- Add rust to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			local src = { "rust", "toml" }

			vim.list_extend(opts.ensure_installed, src, 1, #src)
		end,
	},

	-- Correctly setup mason lsp / dap extensions
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			local src = { "codelldb", "rust-analyzer", "taplo" }

			vim.list_extend(opts.ensure_installed, src, 1, #src)
		end,
	},

	-- Correctly setup lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = { "simrat39/rust-tools.nvim" },
		opts = {
			setup = {
				rust_analyzer = function(_, opts)
					local override_opts = vim.tbl_deep_extend("force", opts, {
						tools = {
							inlay_hints = {
								auto = true,
								show_parameter_hints = true,
							},
						},
						server = {
							settings = {
								["rust-analyzer"] = {
									cargo = {
										features = "all",
									},
									check = {
										command = "clippy",
										features = "all",
									},
									checkOnSave = true,
									procMacro = {
										enable = true,
									},
								},
							},
						},
					})

					require("rust-tools").setup(override_opts)

					return true
				end,
				taplo = function()
					local function show_documentation()
						if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
							require("crates").show_popup()
						else
							vim.lsp.buf.hover()
						end
					end

					require("lazyvim.util").lsp.on_attach(function(client, buffer)
						if client.name == "taplo" then
							vim.keymap.set("n", "K", show_documentation, { buffer = buffer })
						end
					end)

					-- make sure the base implementation calls taplo.setup
					return false
				end,
			},
		},
	},
}
