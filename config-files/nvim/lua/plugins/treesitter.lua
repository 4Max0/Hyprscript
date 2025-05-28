return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require('nvim-treesitter.configs').setup {
        ensure_installed = { "java", "lua", "python", "c", "cpp", "html", "css", "javascript", "sql", "typescript", "bash" },
        highlight = {
            enable = true,
        },
        indent = {
        enable = true,
            },
        }
    end
}
