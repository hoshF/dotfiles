return {

    {
        "mason-org/mason.nvim",
        cmd = "Mason",
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        event = "VeryLazy",
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
