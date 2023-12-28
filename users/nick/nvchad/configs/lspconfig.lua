local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = {
	-- lua
	"lua_ls",

	-- nix
	"nil_ls",

	-- web
	"cssls",
	"html",
	"tsserver",
	"jsonls",

	-- yaml
	"yamlls",

  -- cloudnative
  "helm_ls",
  "terraformls",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

lspconfig["yamlls"].setup({
	settings = {
		yaml = {
			format = {
				bracketSpacing = false,
			},
		},
	},
})
