local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        html = { "prettier" },
        yaml = { "yamlfmt" },
        nix = { "alejandra" },
        terraform = { "terraform_fmt" },
    },

    -- format_on_save = {
    --  timeout_ms = 500,
    --  lsp_fallback = true,
    -- },
}

require("conform").setup(options)
