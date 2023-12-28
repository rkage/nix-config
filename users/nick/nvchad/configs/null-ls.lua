local null_ls = require("null-ls")

local b = null_ls.builtins

local sources = {
	-- web
	b.formatting.prettier.with({ filetypes = { "yaml", "html", "markdown", "css" } }), -- so prettier works only on these filetypes

	-- lua
	b.formatting.stylua,

	-- shell
	b.formatting.shfmt,
	b.formatting.jq,

	-- nix
	b.formatting.nixpkgs_fmt,

	-- config
	b.formatting.taplo,
}

null_ls.setup({
	debug = true,
	sources = sources,
})
