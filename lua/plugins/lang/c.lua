return {
	{
		"p00f/clangd_extensions.nvim",
		lazy = true,
		config = function() end,
		opts = {
			inlay_hints = {
				inline = true,
			},
			ast = {
				kind_icons = {
					Compound = "",
					PackExpansion = "",
					Recovery = "",
					TemplateParamObject = "",
					TemplateTemplateParm = "",
					TemplateTypeParm = "",
					TranslationUnit = "",
				},
				--These require codicons (https://github.com/microsoft/vscode-codicons)
				role_icons = {
					declaration = "",
					expression = "",
					specifier = "",
					statement = "",
					["template argument"] = "",
					type = "",
				},
			},
		},
	},

	-- Add c and cpp to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) ~= "table" then
				return
			end

			vim.list_extend(opts.ensure_installed, { "c", "cpp" }, 1)
		end,
	},

	-- Add codelldb to mason
	{
		"williamboman/mason.nvim",
		optional = true,
		opts = function(_, opts)
			if type(opts.ensure_installed) ~= "table" then
				return
			end

			vim.list_extend(opts.ensure_installed, { "codelldb" }, 1)
		end,
	},

	-- Correctly setup lspconfig
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				-- Ensure mason installs the server
				clangd = {
					keys = {
						{ "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
					},
					root_dir = function(fname)
						return require("lspconfig.util").root_pattern(
							"Makefile",
							"configure.ac",
							"configure.in",
							"config.h.in",
							"meson.build",
							"meson_options.txt",
							"build.ninja"
						)(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
							fname
						) or require("lspconfig.util").find_git_ancestor(fname)
					end,
					capabilities = {
						offsetEncoding = { "utf-16" },
					},
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
					},
					init_options = {
						clangdFileStatus = true,
						completeUnimported = true,
						usePlaceholders = true,
					},
				},
			},
			setup = {
				clangd = function(_, opts)
					local clangd_ext_opts = require("lazyvim.util").opts("clangd_extensions.nvim")
					require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
					return false
				end,
			},
		},
	},
}
