return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatic LSP installation
            { "williamboman/mason.nvim", config = true },
            { "williamboman/mason-lspconfig.nvim" },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "L3MON4D3/LuaSnip" },
        },
        config = function()
        -- Mason Setup
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "jdtls",                -- Java
                "lua_ls",               -- Lua
                "pyright",              -- Python
                "clangd",               -- C / C++
                "html",                 -- HTML
                "cssls",                -- CSS
                "ts_ls",                -- TS & JS
                "sqlls",                -- SQL
                "bashls",               -- Bash
                "rust_analyzer"         -- Rust
            },
        })
        -- Capabilities for autocompletion
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")
        local servers = {
            "jdtls",
            "lua_ls",
            "pyright",
            "clangd",
            "html",
            "cssls",
            "tsserver",
            "sqlls",
            "bashls",
            "rust_analyzer",
        }
        for _, server in ipairs(servers) do
            lspconfig[server].setup({
            capabilities = capabilities,
        })
        end
    end,
    }
}
