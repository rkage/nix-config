return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("configs.conform")
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            indent = { char = "¦" },
            scope = { char = "", show_start = false },
            -- scope = { char = "▏" },
        },
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },

    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "ansible-language-server",
                "yaml-language-server",
                "terraform-ls",
                "tflint",
                "lua-language-server",
                "stylua",
                "prettier",
                "yamlfmt",
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "html",
                "css",
                "json",
                "jsonc",
                "json5",
                "vim",
                "lua",
                "vimdoc",
                "yaml",
                "toml",
                "gitignore",
                "gitattributes",
                "fish",
                "terraform",
                "dockerfile",
                "hcl",
            },
        },
    },
}
