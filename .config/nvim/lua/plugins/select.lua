return {
    "keaising/im-select.nvim",
    config = function()
        require("im_select").setup({
            default_im_select = "keyboard-us",
            default_command = "fcitx5-remote",
            set_default_events = { "InsertLeave" },
            set_previous_events = { "InsertEnter" },
            keep_quiet_on_no_binary = false,
            async_switch_im = true,
        })
    end,
}
