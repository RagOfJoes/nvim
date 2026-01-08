return {
	cmd = { 'vscode-html-language-server', '--stdio' },
	filetypes = {
		'astro',
		'html',
		'blade',
		'javascriptreact',
		'typescriptreact',
		'svelte',
	},
	root_markers = { 'index.html', '.git' },
	init_options = { provideFormatter = true },
}
