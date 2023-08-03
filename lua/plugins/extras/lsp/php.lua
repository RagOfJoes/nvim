return {
	-- Add php to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			local src = { "php", "phpdoc" }

			vim.list_extend(opts.ensure_installed, src, 1, #src)
		end,
	},

	-- Add intelephense and php-cs-fixer to mason
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			local src = {
				"intelephense",
				"phpcs",
				"php-cs-fixer",
			}

			vim.list_extend(opts.ensure_installed, src, 1, #src)
		end,
	},

	-- Correctly setup lspconfig
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				intelephense = {},
			},
		},
		setup = {
			intelephense = function(_, opts)
				local override_opts = vim.tbl_deep_extend("force", opts, {
					settings = {
						intelephense = {
							environment = {
								phpVersion = "7.4",
							},
							files = {
								associations = { "**.*.php", "*.php", "*.phtml" },
							},
							stubs = {
								"apache",
								"bcmath",
								"bz2",
								"calendar",
								"com_dotnet",
								"Core",
								"ctype",
								"curl",
								"date",
								"dba",
								"dom",
								"enchant",
								"exif",
								"FFI",
								"fileinfo",
								"filter",
								"fpm",
								"ftp",
								"gd",
								"gettext",
								"gmp",
								"hash",
								"iconv",
								"imap",
								"intl",
								"json",
								"ldap",
								"libxml",
								"mbstring",
								"meta",
								"mysqli",
								"oci8",
								"odbc",
								"openssl",
								"pcntl",
								"pcre",
								"PDO",
								"pdo_ibm",
								"pdo_mysql",
								"pdo_pgsql",
								"pdo_sqlite",
								"pgsql",
								"Phar",
								"posix",
								"pspell",
								"readline",
								"Reflection",
								"session",
								"shmop",
								"SimpleXML",
								"snmp",
								"soap",
								"sockets",
								"sodium",
								"SPL",
								"sqlite3",
								"standard",
								"superglobals",
								"sysvmsg",
								"sysvsem",
								"sysvshm",
								"tidy",
								"tokenizer",
								"xml",
								"xmlreader",
								"xmlrpc",
								"xmlwriter",
								"xsl",
								"Zend OPcache",
								"zip",
								"zlib",
								"memcached",
							},
						},
					},
				})

				require("lspconfig").intelephense.setup(override_opts)

				return false
			end,
		},
	},
}
