return {
    { "mason-org/mason.nvim", opts = {} },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "pylsp", 
                "rust_analyzer", 
                "clangd",
                "lua_ls",
            },
        },
    },
}
